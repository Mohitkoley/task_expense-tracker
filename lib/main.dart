import 'package:bloc_test/core/common/screen/error_screen.dart';
import 'package:bloc_test/core/constants/box_names.dart';
import 'package:bloc_test/core/di/di.dart';
import 'package:bloc_test/feature/expense_tracker/data/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String defaultPath = (await getApplicationDocumentsDirectory()).path;

  //hive
  Hive.defaultDirectory = defaultPath;
  Hive.registerAdapter<ExpenseModel>(
      BoxNames.expenses, (json) => ExpenseModel.fromJson(json));

  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return ErrorScreen(
      errorText: errorDetails.exceptionAsString(),
    );
  };

  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   lazy: true,
        //   create: (context) => AssesmentBloc(
        //     getAllCategory: GetAllAssesment(

        //     ),
        //   ),
        // ),
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
      // home: const SelfAssessmentsPage(),
    );
  }
}
