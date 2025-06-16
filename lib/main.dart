import 'package:bloc_test/core/common/screen/error_screen.dart';
import 'package:bloc_test/core/di/di.dart';
import 'package:bloc_test/core/service/notification/local_notification_service.dart';
import 'package:bloc_test/feature/todo/presentation/bloc/todo_cubit.dart';
import 'package:bloc_test/feature/todo/presentation/screen/todo_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //hive
  // Hive.defaultDirectory = defaultPath;
  //registering the adapter
  // Hive.registerAdapter<TodoModel>(
  //     ModelNames.expense, (json) => TodoModel.fromJson(json));

  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return ErrorScreen(
      errorText: errorDetails.exceptionAsString(),
    );
  };
  //injecting the dependencies
  await configureDependencies();
  //
  await FlutterLocalNotiServices.askNotificationPermission();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: true,
            create: (_) {
              final assesmentBloc = getIt<TodoCubit>();

              assesmentBloc.getAllTodo();
              return assesmentBloc;

              // return ExpensesBloc(
              //   addExpenses: getIt<AddExpenses>(),
              //   getAllExpenses: getIt<GetAllExpenses>(),
              //   updateExpenses: getIt<UpdateExpenses>(),
              //   deleteExpense: getIt<DeleteExpense>(),
              //   filterExpenses: getIt<FilterExpenses>(),
              // )..add(GetExpensesEvent());
            })
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: TodoHomepage());
  }
}
