import 'package:bloc_test/feature/todo/domain/entity/todo.dart';

abstract interface class TodoRepo {
  Future<List<TodoEntity>> getAllTodos();
  Future<List<TodoEntity>> addTodo(TodoEntity expenseEntity);
  Future<List<TodoEntity>> updateTodo(int index, TodoEntity expenseEntity);
  Future<List<TodoEntity>> deleteTodo(TodoEntity expenseEntity);
  Future<List<TodoEntity>> filterTodo({
    required DateTime dateTime,
    required TodoCategory category,
  });
}
