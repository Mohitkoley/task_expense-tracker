import 'dart:async';

import 'package:bloc_test/core/extension/context_ext.dart';
import 'package:bloc_test/core/extension/num_ext.dart';
import 'package:bloc_test/core/utils/common_datetime_format.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/presentation/bloc/todo_cubit.dart';
import 'package:bloc_test/feature/todo/presentation/screen/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TodoHomepage extends StatefulWidget {
  const TodoHomepage({super.key});
  static late BuildContext openContext;
  @override
  State<TodoHomepage> createState() => _TodoHomepageState();
}

class _TodoHomepageState extends State<TodoHomepage>
    with TickerProviderStateMixin {
  // StreamController<List<TodoModel>> streamController =
  //     StreamController<List<TodoModel>>.broadcast();
  void selectNotification(String? payload) async {
    debugPrint('notification payload: $payload');

    await Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (context) => const AddOrUpdateTodoScreen()),
    );
  }

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await FlutterLocalNotiServices.scheduleDailyNotification(
      //   DateTime.now().add(const Duration(seconds: 10)),
      // );

      context.read<TodoCubit>().getAllTodo();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TodoHomepage.openContext = context;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Todo Homepage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await FlutterLocalNotiServices.showSimpleNotification();
          // await FlutterLocalNotiServices.scheduleDailyNotification();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const AddOrUpdateTodoScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) async {
          if (state is TodoErrorState) {
            context.showSnack(state.message);
          }
        },
        buildWhen: (context, state) => state is! TodoErrorState,
        builder: (context, state) {
          final bloc = context.read<TodoCubit>();
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoLoaded) {
            final currentState = state as TodoLoaded;
            return Column(
              children: [
                StreamBuilder(
                    stream: currentState.currentTimeTodo,
                    builder: (context, snap) {
                      if (snap.data != null) {
                        final todo = snap.data!;
                        return Column(children: [
                          SizedBox(
                            width: context.w,
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(10).copyWith(bottom: 5),
                              child: const Text(
                                "Current Todo",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              // Update expense
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    // Navigate to add expense page
                                    return AddOrUpdateTodoScreen(
                                      todoModel: todo,
                                    );
                                  },
                                ),
                              );
                            },
                            title: Text(todo.title,
                                style: const TextStyle(fontSize: 20)),
                            subtitle: Text(
                                "${todo.startDateTime.dateTime} - ${todo.endDateTime.time}",
                                style: const TextStyle(fontSize: 16)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 2,
                                  child: Checkbox.adaptive(
                                    value: todo.isCompleted,
                                    onChanged: (value) {
                                      context.read<TodoCubit>().updateTodo(
                                            todo.copyWith(
                                              isCompleted: value,
                                            ),
                                          );
                                    },
                                  ),
                                ),
                                // IconButton(
                                //   icon: const Icon(Icons.delete),
                                //   onPressed: () {
                                //     // Delete expense
                                //     context
                                //         .read<TodoCubit>()
                                //         .deleteTodo(currentState.currentTimeTodo!);
                                //   },
                                // ),
                              ],
                            ),
                          )
                        ]);
                      }
                      return const SizedBox();
                    }),
                // else
                //   const Text("No current Task"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    controller: tabController,
                    indicator: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    unselectedLabelColor: Theme.of(context).primaryColor,
                    labelColor: Colors.white,
                    splashBorderRadius: BorderRadius.circular(30),
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              wordSpacing: 0.1,
                              fontSize: 18,
                            ),
                    labelStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              wordSpacing: 0.1,
                              fontSize: 18,
                            ),
                    onTap: (index) {
                      context.read<TodoCubit>().getAllTodo();
                    },
                    tabs: const [
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "completed",
                      ),
                    ],
                  ),
                ),
                10.hBox,
                Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        TodoListWidget(
                          todoList: currentState.unCompletedTodo,
                        ),
                        TodoListWidget(
                          todoList: currentState.completedTodo,
                        ),
                      ]),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key, required this.todoList});
  final Stream<List<TodoModel>> todoList;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: todoList,
        builder: (context, snap) {
          if (snap.data == null || snap.data!.isEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Shimmer(
                    color: Colors.grey[300]!,
                    child: ListTile(
                      title: Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      subtitle: Container(
                        width: 100,
                        height: 12,
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      trailing: Container(
                        width: 80,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (snap.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                snap.data!.length, // Replace with the actual number of expenses
            itemBuilder: (context, index) {
              final todo = snap.data![index];
              return ListTile(
                onTap: () {
                  // Update expense
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        // Navigate to add expense page
                        return AddOrUpdateTodoScreen(
                          todoModel: todo,
                        );
                      },
                    ),
                  );
                },
                title: Text(todo.title,
                    style: const TextStyle(
                      fontSize: 20,
                    ).copyWith(
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                    )),
                subtitle: Text(
                    "${todo.startDateTime.dateTime} - ${todo.endDateTime.time}",
                    style: const TextStyle(fontSize: 18)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox.adaptive(
                        value: todo.isCompleted,
                        onChanged: (value) {
                          context.read<TodoCubit>().updateTodo(
                                todo.copyWith(
                                  isCompleted: value,
                                ),
                              );
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Delete expense
                        context.read<TodoCubit>().deleteTodo(todo);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
