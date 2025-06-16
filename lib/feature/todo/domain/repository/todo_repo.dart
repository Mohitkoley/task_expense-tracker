import 'package:bloc_test/feature/todo/domain/entity/todo.dart';

abstract interface class TodoRepo {
  Stream<List<TodoEntity>> getAllUncomplete();
  Stream<List<TodoEntity>> getAllComplete();
  Future<List<TodoEntity>> addTodo(TodoEntity expenseEntity);
  Future<List<TodoEntity>> updateTodo(TodoEntity expenseEntity);
  Future<List<TodoEntity>> deleteTodo(TodoEntity expenseEntity);
  Future<List<TodoEntity>> filterTodo({
    required DateTime dateTime,
    required TodoCategory category,
  });
  Stream<TodoEntity?> getCurrentTimeTodo();
}
