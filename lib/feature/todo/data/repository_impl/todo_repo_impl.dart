import 'package:bloc_test/feature/todo/data/data_source/todo_data_source.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TodoRepo)
class ExpensesRepoImpl implements TodoRepo {
  final TodoDataSource dataSource;

  ExpensesRepoImpl({required this.dataSource});

  @override
  Future<List<TodoEntity>> addTodo(TodoEntity todoEntity) {
    return dataSource.addTodos(
      TodoModel(
        title: todoEntity.title,
        category: todoEntity.category,
        dateTime: todoEntity.dateTime,
        isCompleted: todoEntity.isCompleted,
        description: todoEntity.description,
      ),
    );
  }

  @override
  Future<List<TodoEntity>> deleteTodo(int index) {
    return dataSource.deleteTodos(index);
  }

  @override
  Future<List<TodoEntity>> filterTodo(
      {required DateTime dateTime, TodoCategory category = TodoCategory.food}) {
    return dataSource.filterTodos(date: dateTime, category: category);
  }

  @override
  Future<List<TodoEntity>> getAllTodos() {
    return dataSource.getAllTodos();
  }

  @override
  Future<List<TodoEntity>> updateTodo(int index, TodoEntity expenseEntity) {
    return dataSource.updateTodos(
      index,
      TodoModel(
        title: expenseEntity.title,
        category: expenseEntity.category,
        dateTime: expenseEntity.dateTime,
        isCompleted: expenseEntity.isCompleted,
        description: expenseEntity.description,
      ),
    );
  }
}
