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
        id: todoEntity.ID,
        kTitle: todoEntity.title,
        kCategory: todoEntity.category,
        kDateTime: todoEntity.dateTime,
        kIsCompleted: todoEntity.isCompleted,
        kDescription: todoEntity.description,
      ),
    );
  }

  @override
  Future<List<TodoEntity>> deleteTodo(TodoEntity todoEntity) {
    return dataSource.deleteTodos(TodoModel(
      id: todoEntity.ID,
      kTitle: todoEntity.title,
      kCategory: todoEntity.category,
      kDateTime: todoEntity.dateTime,
      kIsCompleted: todoEntity.isCompleted,
      kDescription: todoEntity.description,
    ));
  }

  @override
  Future<List<TodoEntity>> filterTodo(
      {required DateTime dateTime, TodoCategory category = TodoCategory.food}) {
    return dataSource.filterTodos(date: dateTime, category: category);
  }

  @override
  Future<List<TodoEntity>> getAllUncomplete() {
    return dataSource.getUnCompleteTodos();
  }

  @override
  Future<List<TodoEntity>> updateTodo(int index, TodoEntity expenseEntity) {
    return dataSource.updateTodos(
      index,
      TodoModel(
        id: expenseEntity.ID,
        kTitle: expenseEntity.title,
        kCategory: expenseEntity.category,
        kDateTime: expenseEntity.dateTime,
        kIsCompleted: expenseEntity.isCompleted,
        kDescription: expenseEntity.description,
      ),
    );
  }

  @override
  Future<List<TodoEntity>> getAllComplete() {
    return dataSource.getCompleteTodos();
  }
}
