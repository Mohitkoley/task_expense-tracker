import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/domain/entity/weekly_todo.dart';
import 'package:dart_either/dart_either.dart';

abstract interface class TodoRepo {
  Stream<List<TodoEntity>> getAllUncomplete();
  Stream<List<TodoEntity>> getAllComplete();
  Future<List<TodoEntity>> addTodo(TodoEntity expenseEntity);
  Future<List<TodoEntity>> updateTodo(TodoEntity expenseEntity);
  Future<List<TodoEntity>> deleteTodo(TodoEntity expenseEntity);
  Future<List<TodoEntity>> filterTodo({
    required DateTime dateTime,
    required Priority category,
  });
  Stream<Either<TodoEntity?, TodoModel?>> getCurrentTimeTodo();

  Stream<List<WeeklyTodoEntity>> getWeeklyTodo(DateTime date);
}
