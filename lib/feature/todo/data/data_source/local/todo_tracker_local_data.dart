import 'package:bloc_test/feature/todo/data/data_source/todo_data_source.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: TodoDataSource)
class ExpenseTrackerLocalDataSourceImpl implements TodoDataSource {
  final Isar isar;
  final IsarCollection<int, TodoModel> todos;
  ExpenseTrackerLocalDataSourceImpl(this.todos, this.isar);
  DateTime _startOfToday() => DateTime.now()
      .toLocal()
      .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  DateTime _startOfTomorrow() => _startOfToday().add(const Duration(days: 1));

  @override
  Future<List<TodoModel>> addTodos(TodoModel todoModel) async {
    try {
      await isar.writeAsync((isar) {
        isar.todoModels.put(todoModel);
      });
    } on Exception {
      rethrow;
    }
    return getUnCompleteTodos().last;
  }

  @override
  Future<List<TodoModel>> deleteTodos(TodoModel todoModel) async {
    try {
      await isar.writeAsync((isar) {
        isar.todoModels.delete(todoModel.id);
      });
    } on Exception {
      rethrow;
    }
    return getUnCompleteTodos().last;
  }

  @override
  Stream<TodoModel?> getCurrentTimeTodo() {
    final now = DateTime.now();
    try {
      // Emits every 5 seconds
      final timerStream =
          Stream.periodic(const Duration(seconds: 5), (_) => DateTime.now());

      // Emits when any todo changes
      final dataStream = todos.watchLazy(fireImmediately: true);

      // Combine both: either time changes OR data changes
      return Rx.combineLatest2(
              timerStream, dataStream, (_, __) => DateTime.now())
          .asyncMap((_) async {
        final now = DateTime.now();

        final todo = todos
            .where()
            .isCompletedEqualTo(false)
            .startDateTimeLessThanOrEqualTo(now)
            .endDateTimeGreaterThanOrEqualTo(now)
            .build()
            .findFirst();

        return todo;
      });
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<TodoModel>> filterTodos(
      {required DateTime date, required TodoCategory category}) async {
    List<TodoModel> todos = await getUnCompleteTodos().last;
    try {
      for (int i = 0; i < todos.length; i++) {
        if (DateUtils.isSameDay(todos[i].kStartDateTime, date) ||
            todos[i].category == category) {
          todos.add(todos[i]);
        }
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return todos;
  }

  @override
  Stream<List<TodoModel>> getUnCompleteTodos() {
    try {
      final allTodos = todos
          .where()
          .isCompletedEqualTo(false)
          .startDateTimeBetween(
            DateTime.now().subtract(const Duration(days: 1)),
            _startOfTomorrow(),
          )
          .build()
          .watch(fireImmediately: true);

      return allTodos;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<TodoModel>> updateTodos(TodoModel expenseEntity) async {
    try {
      await isar.writeAsync((isar) {
        isar.todoModels.put(expenseEntity);
      });
    } on Exception {
      rethrow;
    }
    return getUnCompleteTodos().last;
  }

  @override
  Stream<List<TodoModel>> getCompleteTodos() {
    try {
      final allTodos = todos
          .where()
          .isCompletedEqualTo(true)
          .build()
          .watch(fireImmediately: true);
      return allTodos;
    } on Exception {
      rethrow;
    }
  }
}
