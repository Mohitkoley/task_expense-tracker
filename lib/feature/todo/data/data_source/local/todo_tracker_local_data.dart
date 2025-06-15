import 'package:bloc_test/feature/todo/data/data_source/todo_data_source.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@LazySingleton(as: TodoDataSource)
class ExpenseTrackerLocalDataSourceImpl implements TodoDataSource {
  final Isar isar;
  final IsarCollection<int, TodoModel> todos;
  ExpenseTrackerLocalDataSourceImpl(this.todos, this.isar);

  @override
  Future<List<TodoModel>> addTodos(TodoModel todoModel) async {
    try {
      await isar.writeAsync((isar) {
        isar.todoModels.put(todoModel);
      });
    } on Exception {
      rethrow;
    }
    return getUnCompleteTodos();
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
    return getUnCompleteTodos();
  }

  @override
  Future<List<TodoModel>> filterTodos(
      {required DateTime date, required TodoCategory category}) async {
    List<TodoModel> todos = await getUnCompleteTodos();
    try {
      for (int i = 0; i < todos.length; i++) {
        if (DateUtils.isSameDay(todos[i].kDateTime, date) ||
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
  Future<List<TodoModel>> getUnCompleteTodos() async {
    List<TodoModel> expenses = [];
    try {
      if (todos.count() == 0) {
        return expenses;
      }
      final allTodos = todos
          .where()
          .isCompletedEqualTo(false)
          .dateTimeBetween(DateTime.now().subtract(const Duration(days: 1)),
              DateTime.now().add(const Duration(days: 1)))
          .findAll();
      expenses.addAll(allTodos);
    } on Exception {
      rethrow;
    }
    return expenses;
  }

  @override
  Future<List<TodoModel>> updateTodos(
      int index, TodoModel expenseEntity) async {
    try {
      await isar.writeAsync((isar) {
        isar.todoModels.put(expenseEntity);
      });
    } on Exception {
      rethrow;
    }
    return getUnCompleteTodos();
  }

  @override
  Future<List<TodoModel>> getCompleteTodos() async {
    List<TodoModel> expenses = [];
    try {
      if (todos.count() == 0) {
        return expenses;
      }
      List<TodoModel> allTodos =
          todos.where().isCompletedEqualTo(true).findAll();
      allTodos = allTodos
          .where((ele) => DateUtils.isSameDay(ele.dateTime, DateTime.now()))
          .toList();
      expenses.addAll(allTodos);
    } on Exception {
      rethrow;
    }
    return expenses;
  }
}
