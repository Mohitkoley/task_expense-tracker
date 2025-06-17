import 'dart:async';

import 'package:bloc_test/core/extension/context_ext.dart';
import 'package:bloc_test/core/extension/num_ext.dart';
import 'package:bloc_test/core/utils/common_datetime_format.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/presentation/bloc/todo_cubit.dart';
import 'package:bloc_test/feature/todo/presentation/screen/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoHomepage extends StatefulWidget {
  const TodoHomepage({super.key});
  static late BuildContext openContext;
  @override
  State<TodoHomepage> createState() => _TodoHomepageState();
}

class _TodoHomepageState extends State<TodoHomepage>
    with TickerProviderStateMixin {
  late TabController tabController;

  void selectNotification(String? payload) async {
    debugPrint('notification payload: $payload');

    await Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (context) => const AddOrUpdateTodoScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
        listener: (context, state) async {},
        buildWhen: (context, state) => state.status != TodoStatus.error,
        builder: (context, state) {
          TodoState currentState = state;
          return switch (state.status) {
            TodoStatus.initial => const SizedBox(),
            TodoStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            TodoStatus.error => const SizedBox(),
            TodoStatus.loaded => NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      title: const Text('My App Bar'),
                      pinned: true, // Keeps the app bar visible at the top
                      floating:
                          true, // Allows the app bar to reappear when scrolling up
                      // Height when expanded

                      bottom: TabBar(
                        controller: tabController,
                        tabs: const <Tab>[
                          Tab(text: 'Today'),
                          Tab(text: 'weekly'),
                        ],
                      ),
                      forceElevated:
                          innerBoxIsScrolled, // Shows shadow when scrolled
                    ),
                  ];
                },
                body: TabBarView(
                  controller: tabController,
                  children: [
                    // Content for Tab 1 (SliverList)

                    TodayTab(currentState: currentState),
                    WeeklyTab(currentState: currentState),
                  ],
                ),
              )
          };
        },
      ),
    );
  }
}

class WeeklyTab extends StatefulWidget {
  const WeeklyTab({
    super.key,
    required this.currentState,
  });
  final TodoState currentState;

  @override
  State<WeeklyTab> createState() => _WeeklyTabState();
}

class _WeeklyTabState extends State<WeeklyTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      key: const PageStorageKey<String>('Tab2'),
      slivers: <Widget>[
        // Instead of SingleChildScrollView, directly put your content as slivers
        SliverToBoxAdapter(
          // Use SliverToBoxAdapter for single, non-list widgets
          child: Column(
            // If you need a column, put it inside SliverToBoxAdapter
            children: [
              // Your widgets that were previously inside SingleChildScrollView
              const Text('Some content at the top'),
              Container(height: 100, color: Colors.red),
            ],
          ),
        ),
        SliverList(
          // For list-like content, use SliverList
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(title: Text('List Item $index'));
            },
            childCount: 50,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TodayTab extends StatefulWidget {
  const TodayTab({
    super.key,
    required this.currentState,
  });

  final TodoState currentState;

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      // This is the scrollable for the tab
      // key: const PageStorageKey<String>('Tab1'),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: CurrentTodo(currentState: widget.currentState),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(
                    text: "Upcoming",
                  ),
                  TodoListWidget(
                    todoList: widget.currentState.unCompletedTodo,
                  ),
                  10.hBox,
                  const Header(
                    text: "Completed",
                  ),
                  TodoListWidget(
                    todoList: widget.currentState.completedTodo,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class CurrentTodo extends StatelessWidget {
  const CurrentTodo({
    super.key,
    required this.currentState,
  });

  final TodoState currentState;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: currentState.currentTimeTodo,
      builder: (context, snap) {
        if (snap.data != null) {
          final todo = snap.data!;
          return Column(
            children: [
              SizedBox(
                width: context.w,
                child: Padding(
                  padding: const EdgeInsets.all(10).copyWith(bottom: 5),
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
                title: Text(todo.title, style: const TextStyle(fontSize: 20)),
                subtitle: Text(
                    "${todo.startDateTime.dateTime} - ${todo.endDateTime.time}",
                    style: const TextStyle(fontSize: 16)),
                leading: Transform.scale(
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
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

//  CustomScrollView(
//                     key: const PageStorageKey<String>('Tab1'),
//                     slivers: [
//                       SliverList(
//                         delegate: SliverChildListDelegate(
//                           [
//                             StreamBuilder(
//                               stream: currentState.currentTimeTodo,
//                               builder: (context, snap) {
//                                 if (snap.data != null) {
//                                   final todo = snap.data!;
//                                   return Column(children: [
//                                     SizedBox(
//                                       width: context.w,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(10)
//                                             .copyWith(bottom: 5),
//                                         child: const Text(
//                                           "Current Todo",
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(fontSize: 18),
//                                         ),
//                                       ),
//                                     ),
//                                     ListTile(
//                                       onTap: () {
//                                         // Update expense
//                                         Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                             builder: (context) {
//                                               // Navigate to add expense page
//                                               return AddOrUpdateTodoScreen(
//                                                 todoModel: todo,
//                                               );
//                                             },
//                                           ),
//                                         );
//                                       },
//                                       title: Text(todo.title,
//                                           style: const TextStyle(fontSize: 20)),
//                                       subtitle: Text(
//                                           "${todo.startDateTime.dateTime} - ${todo.endDateTime.time}",
//                                           style: const TextStyle(fontSize: 16)),
//                                       leading: Transform.scale(
//                                         scale: 2,
//                                         child: Checkbox.adaptive(
//                                           value: todo.isCompleted,
//                                           onChanged: (value) {
//                                             context
//                                                 .read<TodoCubit>()
//                                                 .updateTodo(
//                                                   todo.copyWith(
//                                                     isCompleted: value,
//                                                   ),
//                                                 );
//                                           },
//                                         ),
//                                       ),
//                                     )
//                                   ]);
//                                 }
//                                 return const SizedBox();
//                               },
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Header(
//                                   text: "Upcoming",
//                                 ),
//                                 TodoListWidget(
//                                   todoList: currentState.unCompletedTodo,
//                                 ),
//                                 10.hBox,
//                                 const Header(
//                                   text: "Completed",
//                                 ),
//                                 TodoListWidget(
//                                   todoList: currentState.completedTodo,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   CustomScrollView(
//                     key: const PageStorageKey<String>('Tab2'),
//                     slivers: [],
//                   ),

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key, required this.todoList});
  final Stream<List<TodoModel>> todoList;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: todoList,
        builder: (context, snap) {
          if (snap.data == null || snap.data!.isEmpty) {
            return SizedBox(
              height: context.h * 0.2,
              child: const Center(child: Text("No Todo")),
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
                leading: Transform.scale(
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
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Delete expense
                    context.read<TodoCubit>().deleteTodo(todo);
                  },
                ),
              );
            },
          );
        });
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
