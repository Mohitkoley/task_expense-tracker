import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:dart_either/dart_either.dart';

abstract interface class TodoDataSource {
  Stream<List<TodoModel>> getUnCompleteTodos();
  Stream<List<TodoModel>> getCompleteTodos();
  Future<List<TodoModel>> addTodos(TodoModel expenseEntity);
  Future<List<TodoModel>> updateTodos(TodoModel expenseModel);
  Future<List<TodoModel>> deleteTodos(TodoModel expenseEntity);
  Stream<Either<TodoModel?, TodoModel?>> getCurrentTimeTodo();
  Stream<List<TodoModel>> getWeeklyTodos(DateTime date);

  Future<List<TodoModel>> filterTodos({
    required DateTime date,
    required Priority category,
  });
}
