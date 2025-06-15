// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ffi';
import 'dart:io';

import 'package:bloc_test/core/common/screen/error_screen.dart';
import 'package:bloc_test/core/constants/box_names.dart';
import 'package:bloc_test/core/di/di.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/presentation/bloc/todo_bloc.dart';
import 'package:bloc_test/feature/todo/presentation/screen/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

void main() {
  const _releases = 'https://github.com/isar/isar/releases/download/';

  group('My Widget Tests', () {
    // This setUpAll function is called once before any test case in the group
    setUpAll(() async {
      // This is where you can do some setup before all the tests in the group
      WidgetsFlutterBinding.ensureInitialized();

      final lib = switch (Abi.current()) {
        Abi.macosArm64 || Abi.macosX64 => 'libisar_macos.dylib',
        Abi.linuxX64 => 'libisar_linux_x64.so',
        Abi.windowsX64 => 'isar_windows_x64.dll',
        _ => throw UnsupportedError('Unsupported test platform'),
      };

      final libPath = Directory.current.path + Platform.pathSeparator + lib;
      final file = File(libPath);

      // if (!file.existsSync()) {
      //   throw ArgumentError('Failed to load dynamic library: $libPath');
      // }
      if (!file.existsSync()) {
        final uri = Uri.parse('$_releases/${Isar.version}/$lib');
        final request = await HttpClient().getUrl(uri);
        final response = await request.close();
        await response.pipe(file.openWrite());
      }
      // hive
      Hive.defaultDirectory = Directory.systemTemp.path;
      Hive.registerAdapter<TodoModel>(
          ModelNames.expense, (json) => TodoModel.fromJson(json));

      ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
        return ErrorScreen(
          errorText: errorDetails.exceptionAsString(),
        );
      };

      configureDependencies();
      // await FlutterLocalNotiServices.askNotificationPermission();
    });

    testWidgets(
      'Add expense test',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                lazy: true,
                create: (_) {
                  final assesmentBloc = getIt<ExpensesBloc>(
                    instanceName: 'ExpensesBloc',
                  );

                  assesmentBloc.add(GetTodoEvent());
                  return assesmentBloc;
                },
              ),
            ],
            child: const MaterialApp(home: AddExpensesScreen()),
          ),
        );

        // Verify that the initial state is correct.
        expect(find.text('Add Expense'), findsOneWidget);
        expect(find.text('Enter Amount'), findsOneWidget);
        expect(find.text('Enter Description'), findsOneWidget);

        // Enter amount.
        await tester.enterText(find.byType(TextField).first, '100');

        // Select category.
        await tester.tap(find.byType(DropdownButtonFormField<TodoCategory>));
        // open the dropdown
        await tester.pumpAndSettle();
        // select the first item
        await tester.tap(find.text('food').last);
        // close the dropdown
        await tester.pumpAndSettle();

        // Enter description.
        await tester.enterText(find.byType(TextFormField), 'Lunch');

        // Tap the save button.
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();

        // Verify that the expense has been added.
        expect(find.text('Add Expense'), findsNothing);
        expect(find.text('Edit Expense'), findsOneWidget);
      },
    );
  });
}
