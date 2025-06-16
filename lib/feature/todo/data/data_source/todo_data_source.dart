import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';

abstract interface class TodoDataSource {
  Stream<List<TodoModel>> getUnCompleteTodos();
  Stream<List<TodoModel>> getCompleteTodos();
  Future<List<TodoModel>> addTodos(TodoModel expenseEntity);
  Future<List<TodoModel>> updateTodos(int index, TodoModel expenseModel);
  Future<List<TodoModel>> deleteTodos(TodoModel expenseEntity);

  Future<List<TodoModel>> filterTodos({
    required DateTime date,
    required TodoCategory category,
  });
}
