import 'package:bloc_test/feature/todo/presentation/bloc/todo_cubit.dart';
import 'package:bloc_test/feature/todo/presentation/screen/add_todo_screen.dart';
import 'package:bloc_test/feature/todo/presentation/screen/old/old_ui.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await FlutterLocalNotiServices.scheduleDailyNotification(
      //   DateTime.now().add(const Duration(seconds: 10)),
      // );

      context.read<TodoCubit>()
        ..getAllTodo()
        ..getWeeklyTodo(DateTime.now());
    });
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
            TodoStatus.loaded => OldUI(currentState: currentState)
          };
        },
      ),
    );
  }
}
