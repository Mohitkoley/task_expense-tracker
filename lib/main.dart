import 'package:bloc_test/core/common/screen/error_screen.dart';
import 'package:bloc_test/core/constants/box_names.dart';
import 'package:bloc_test/core/di/di.dart';
import 'package:bloc_test/core/service/notification/local_notification_service.dart';
import 'package:bloc_test/feature/expense_tracker/data/model/expense_model.dart';
import 'package:bloc_test/feature/expense_tracker/presentation/bloc/expenses_bloc.dart';
import 'package:bloc_test/feature/expense_tracker/presentation/screen/expenses_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String defaultPath = (await getApplicationDocumentsDirectory()).path;

  //hive
  Hive.defaultDirectory = defaultPath;
  //registering the adapter
  Hive.registerAdapter<ExpenseModel>(
      ModelNames.expense, (json) => ExpenseModel.fromJson(json));

  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return ErrorScreen(
      errorText: errorDetails.exceptionAsString(),
    );
  };
  //injecting the dependencies
  configureDependencies();
  //
  await FlutterLocalNotiServices.askNotificationPermission();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: true,
            create: (_) {
              final assesmentBloc = getIt<ExpensesBloc>(
                instanceName: 'ExpensesBloc',
              );

              assesmentBloc.add(GetExpensesEvent());
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
        home: ExpensesHomepage());
  }
}
