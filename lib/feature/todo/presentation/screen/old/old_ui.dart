import 'package:bloc_test/core/extension/context_ext.dart';
import 'package:bloc_test/core/extension/num_ext.dart';
import 'package:bloc_test/core/utils/date/common_datetime_format.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/data/model/weekly_todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/presentation/bloc/todo_cubit.dart';
import 'package:bloc_test/feature/todo/presentation/screen/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OldUI extends StatefulWidget {
  const OldUI({
    super.key,
    required this.currentState,
  });

  final TodoState currentState;

  @override
  State<OldUI> createState() => _OldUIState();
}

class _OldUIState extends State<OldUI> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = tabController = TabController(length: 2, vsync: this);
  }

  @override
  dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: const Text('Todo List'),
            pinned: true, // Keeps the app bar visible at the top
            floating: true, // Allows the app bar to reappear when scrolling up
            // Height when expanded

            bottom: TabBar(
              controller: tabController,
              tabs: const <Tab>[
                Tab(text: 'Today'),
                Tab(text: 'weekly'),
              ],
            ),
            forceElevated: innerBoxIsScrolled, // Shows shadow when scrolled
          ),
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: [
          // Content for Tab 1 (SliverList)

          TodayTab(currentState: widget.currentState),
          WeeklyTab(currentState: widget.currentState),
        ],
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
        const SliverToBoxAdapter(
          // Use SliverToBoxAdapter for single, non-list widgets
          child: Column(
            // If you need a column, put it inside SliverToBoxAdapter
            children: [
              // Your widgets that were previously inside SingleChildScrollView
              Text(
                "Change date",
              ),
            ],
          ),
        ),
        WeeklyTodoListView(
          weeklyTodo: widget.currentState.weeklyTodo,
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class WeeklyTodoListView extends StatelessWidget {
  const WeeklyTodoListView({
    super.key,
    required this.weeklyTodo,
  });

  final Stream<List<WeeklyTodoModel>> weeklyTodo;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: weeklyTodo,
        builder: (context, snap) {
          if (snap.data != null) {
            if (snap.data!.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text("No todo for this week"),
                ),
              );
            }
            final week = snap.data!;
            return SliverList.separated(
                itemBuilder: (context, index) {
                  return TodoWidget(
                    todo: week[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 30,
                  );
                },
                itemCount: week.length);
          }

          // if ((snap.data ?? []).isEmpty) {
          //   return Column(
          //     children: List.generate(
          //         5,
          //         (index) => Shimmer(
          //               color: Colors.grey[300]!,
          //               child: Container(
          //                 margin: const EdgeInsets.all(10),
          //                 height: 60,
          //                 decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.circular(8),
          //                 ),
          //               ),
          //             )),
          //   );
          // }
          return const SliverFillRemaining(child: SizedBox());
          //return shimmer
        });
  }
}

class TodoWidget extends StatelessWidget {
  final WeeklyTodoModel todo;
  const TodoWidget({
    super.key,
    required this.todo,
  });

  final taskStyle = const TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.date.weekdayName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text(todo.date.textWithoutTime),
            ],
          ),
          10.wBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(todo.todos.length, (index) {
              final todo = this.todo.todos[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.startDateTime.time24,
                      style: taskStyle,
                    ),
                    20.wBox,
                    SizedBox(
                      width: context.w * 0.35,
                      child: Text(
                        todo.title,
                        style: taskStyle,
                        maxLines: 3,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          // show dialog to edit todo

                          showDialog(
                              context: context,
                              builder: (context) {
                                return EditPopUp(
                                  todo: todo,
                                );
                              });
                        },
                        child: const Icon(Icons.edit)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class EditPopUp extends StatefulWidget {
  EditPopUp({super.key, required TodoEntity todo})
      : todo = TodoModel.fromEntity(todo);
  TodoModel todo;

  @override
  State<EditPopUp> createState() => _EditPopUpState();
}

class _EditPopUpState extends State<EditPopUp> {
  TextEditingController startTimeEditingController = TextEditingController();
  TextEditingController endTimeEditingController = TextEditingController();

  Priority category = Priority.low;

  @override
  void initState() {
    super.initState();
    startTimeEditingController = TextEditingController.fromValue(
        TextEditingValue(text: widget.todo.startDateTime.time2));

    endTimeEditingController = TextEditingController.fromValue(
        TextEditingValue(text: widget.todo.endDateTime.time2));

    category = widget.todo.priority;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startTimeEditingController.dispose();
    endTimeEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: widget.todo.title,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            onChanged: (value) {
              widget.todo = widget.todo.copyWith(title: value);
              context.read<TodoCubit>().updateTodo(widget.todo);
            },
          ),
          16.hBox,
          TextFormField(
            initialValue: widget.todo.description,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            onChanged: (value) {
              widget.todo = widget.todo.copyWith(description: value);
              context.read<TodoCubit>().updateTodo(widget.todo);
            },
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: startTimeEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Start Time',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay.fromDateTime(widget.todo.startDateTime),
                    );
                    if (time != null) {
                      final newDateTime = DateTime(
                        widget.todo.startDateTime.year,
                        widget.todo.startDateTime.month,
                        widget.todo.startDateTime.day,
                        time.hour,
                        time.minute,
                      );
                      final todo =
                          widget.todo.copyWith(startDateTime: newDateTime);
                      startTimeEditingController.text = newDateTime.time24;
                      widget.todo = todo;
                      context.read<TodoCubit>().updateTodo(todo);
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: endTimeEditingController,
                  decoration: const InputDecoration(
                    labelText: 'End Time',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay.fromDateTime(widget.todo.endDateTime),
                    );
                    if (time != null) {
                      final newDateTime = DateTime(
                        widget.todo.endDateTime.year,
                        widget.todo.endDateTime.month,
                        widget.todo.endDateTime.day,
                        time.hour,
                        time.minute,
                      );

                      if (newDateTime == widget.todo.startDateTime ||
                          newDateTime.isBefore(widget.todo.startDateTime)) {
                        context
                            .showSnack("start Time and end Time can't be same");
                      } else {
                        final todo =
                            widget.todo.copyWith(endDateTime: newDateTime);
                        endTimeEditingController.text = newDateTime.time24;
                        context.read<TodoCubit>().updateTodo(todo);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
          10.hBox,
          DropdownButtonFormField(
            validator: (value) {
              if (value == null) {
                return 'Please select a category';
              }
              return null;
            },
            items: Priority.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toJson()),
                    ))
                .toList(),
            value: category,
            onChanged: (Priority? value) {
              category = value!;
              widget.todo = widget.todo.copyWith(kpriority: category);
              context.read<TodoCubit>().updateTodo(widget.todo);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
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
        const SliverToBoxAdapter(
          child: Header(
            text: "UnFinised",
          ),
        ),
        TodoListWidget(
          todoList: widget.currentState.unCompletedTodo,
        ),
        const SliverToBoxAdapter(
          child: Header(
            text: "Completed",
          ),
        ),
        TodoListWidget(
          todoList: widget.currentState.completedTodo,
        ),
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

          return todo.fold(ifLeft: (todo) {
            if (todo != null) {
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
                    title:
                        Text(todo.title, style: const TextStyle(fontSize: 20)),
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
          }, ifRight: (nextTodo) {
            if (nextTodo != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${nextTodo.title} is at ${nextTodo.startDateTime.time2}",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            }
            return const SizedBox();
          });
        }
        return const SizedBox();
      },
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
            return SliverToBoxAdapter(
              child: SizedBox(
                  height: context.h * 0.4,
                  child: const Center(child: Text("No Todo"))),
            );
          }
          if (snap.hasError) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text("Error"),
              ),
            );
          }
          return SliverList.builder(
            itemCount:
                snap.data!.length, // Replace with the actual number of expenses
            itemBuilder: (context, index) {
              final todo = snap.data![index];
              return TodoListItem(todo: todo);
            },
          );
        });
  }
}

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
  });

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
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
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
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
