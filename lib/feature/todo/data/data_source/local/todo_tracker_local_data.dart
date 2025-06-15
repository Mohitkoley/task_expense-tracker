import 'package:bloc_test/feature/todo/data/data_source/todo_data_source.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
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
      todos.put(todoModel);
    } on Exception {
      rethrow;
    }
    return getAllTodos();
  }

  @override
  Future<List<TodoModel>> deleteTodos(TodoModel todoModel) async {
    try {
      todos.delete(todoModel.id);
    } on Exception {
      rethrow;
    }
    return getAllTodos();
  }

  @override
  Future<List<TodoModel>> filterTodos(
      {required DateTime date, required TodoCategory category}) async {
    List<TodoModel> todos = [];
    try {
      if (todos.isEmpty) {
        return todos;
      }
      for (int i = 0; i < todos.length; i++) {
        if (todos[i].dateTime == date || todos[i].category == category) {
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
  Future<List<TodoModel>> getAllTodos() async {
    List<TodoModel> expenses = [];
    try {
      if (todos.count() == 0) {
        return expenses;
      }
      final allTodos = todos.where().findAll();
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
      todos.put(expenseEntity);
    } on Exception {
      rethrow;
    }
    return getAllTodos();
  }
}
