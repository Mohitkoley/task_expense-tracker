import 'package:bloc_test/core/extension/context_ext.dart';
import 'package:bloc_test/core/extension/num_ext.dart';
import 'package:bloc_test/core/service/notification/local_notification_service.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/presentation/bloc/todo_bloc.dart';
import 'package:bloc_test/feature/todo/presentation/screen/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesHomepage extends StatefulWidget {
  ExpensesHomepage({super.key});
  static late BuildContext openContext;
  @override
  State<ExpensesHomepage> createState() => _ExpensesHomepageState();
}

class _ExpensesHomepageState extends State<ExpensesHomepage> {
  void selectNotification(String? payload) async {
    debugPrint('notification payload: $payload');

    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => AddExpensesScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await FlutterLocalNotiServices.scheduleDailyNotification(
        DateTime.now().add(const Duration(seconds: 10)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ExpensesHomepage.openContext = context;
    return Scaffold(
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
                return const AddExpensesScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoErrorState) {
            context.showSnack(state.message);
          }
        },
        buildWhen: (context, state) => state is! TodoErrorState,
        builder: (context, state) {
          final bloc = context.read<TodoBloc>();
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoLoaded) {
            final currentState = state;
            return Column(
              children: [
                SizedBox(
                  height: context.h * 0.07,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Filter by date
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              debugPrint(value.toString());
                              bloc.add(FilterTodoEvent(
                                date: value,
                              ));
                            }
                          });
                        },
                        child: const Text('Filter by Date'),
                      ),
                      30.wBox,
                      SizedBox(
                        width: context.w * 0.4,
                        height: context.h * 0.05,
                        child: DropdownButtonFormField(
                          items: TodoCategory.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.toJson()),
                                  ))
                              .toList(),
                          value: bloc.expenseCategory,
                          onChanged: (TodoCategory? value) {
                            bloc.expenseCategory = value;
                            bloc.add(FilterTodoEvent(
                              date: DateTime.now(),
                              category: bloc.expenseCategory!,
                            ));
                          },
                        ),
                      ),

                      // clear filter
                      if (bloc.expenseCategory != null)
                        IconButton.filled(
                            iconSize: 30,
                            onPressed: () {
                              bloc.expenseCategory = null;
                              bloc.add(GetTodoEvent());
                            },
                            icon: Icon(Icons.clear)),
                    ],
                  ),
                ),
                10.hBox,
                currentState.categoryList.isEmpty
                    ? SizedBox(
                        height: context.h * 0.5,
                        width: context.w,
                        child: const Text('No expenses found'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentState.categoryList
                            .length, // Replace with the actual number of expenses
                        itemBuilder: (context, index) {
                          final expense = currentState.categoryList[index];
                          return ListTile(
                            title: Text('Title ${expense.title}'),
                            subtitle: Text(
                                '${expense.category.name} - ${expense.dateTime.toLocal().toString().split('.')[0]}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Update expense
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          // Navigate to add expense page
                                          return AddExpensesScreen(
                                            todoModel: expense,
                                            index: index,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Delete expense
                                    context.read<TodoBloc>().add(
                                          DeleteTodoEvent(index),
                                        );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
