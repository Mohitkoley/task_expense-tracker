import 'package:bloc_test/feature/todo/data/data_source/todo_data_source.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TodoDataSource)
class ExpenseTrackerLocalDataSourceImpl implements TodoDataSource {
  final Box<TodoModel> box;
  ExpenseTrackerLocalDataSourceImpl(this.box);

  @override
  Future<List<TodoModel>> addTodos(TodoModel expenseModel) async {
    try {
      box.add(expenseModel);
    } on Exception {
      rethrow;
    }
    return getAllTodos();
  }

  @override
  Future<List<TodoModel>> deleteTodos(int index) async {
    try {
      box.deleteAt(index);
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
      if (box.isEmpty) {
        return todos;
      }
      for (int i = 0; i < box.length; i++) {
        if (box.getAt(i).dateTime == date ||
            box.getAt(i).category == category) {
          todos.add(box.getAt(i));
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
      if (box.isEmpty) {
        return expenses;
      }
      for (int i = 0; i < box.length; i++) {
        expenses.add(box.getAt(i));
      }
    } on Exception {
      rethrow;
    }
    return expenses;
  }

  @override
  Future<List<TodoModel>> updateTodos(
      int index, TodoModel expenseEntity) async {
    try {
      box.putAt(index, expenseEntity);
    } on Exception {
      rethrow;
    }
    return getAllTodos();
  }
}
