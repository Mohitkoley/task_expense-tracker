import 'package:bloc_test/core/service/notification/local_notification_service.dart';
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
    var todoModel = TodoModel(
      kEndDateTime: todoEntity.endDateTime,
      id: todoEntity.ID,
      kTitle: todoEntity.title,
      kCategory: todoEntity.category,
      kStartDateTime: todoEntity.startDateTime,
      kIsCompleted: todoEntity.isCompleted,
      kDescription: todoEntity.description,
    );
    FlutterLocalNotiServices.scheduleTodoNotification(todoModel);
    return dataSource.addTodos(
      todoModel,
    );
  }

  @override
  Future<List<TodoEntity>> deleteTodo(TodoEntity todoEntity) {
    var todoModel = TodoModel(
      id: todoEntity.ID,
      kEndDateTime: todoEntity.endDateTime,
      kTitle: todoEntity.title,
      kCategory: todoEntity.category,
      kStartDateTime: todoEntity.startDateTime,
      kIsCompleted: todoEntity.isCompleted,
      kDescription: todoEntity.description,
    );
    FlutterLocalNotiServices.removeScheduleTodoNotification(todoModel);
    return dataSource.deleteTodos(todoModel);
  }

  @override
  Future<List<TodoEntity>> filterTodo(
      {required DateTime dateTime, TodoCategory category = TodoCategory.food}) {
    return dataSource.filterTodos(date: dateTime, category: category);
  }

  @override
  Stream<List<TodoEntity>> getAllUncomplete() {
    return dataSource.getUnCompleteTodos();
  }

  @override
  Future<List<TodoEntity>> updateTodo(TodoEntity expenseEntity) {
    final todo = TodoModel(
      kEndDateTime: expenseEntity.endDateTime,
      id: expenseEntity.ID,
      kTitle: expenseEntity.title,
      kCategory: expenseEntity.category,
      kStartDateTime: expenseEntity.startDateTime,
      kIsCompleted: expenseEntity.isCompleted,
      kDescription: expenseEntity.description,
    );
    FlutterLocalNotiServices.scheduleTodoNotification(todo);
    return dataSource.updateTodos(todo);
  }

  @override
  Stream<List<TodoEntity>> getAllComplete() {
    return dataSource.getCompleteTodos();
  }

  @override
  Stream<TodoEntity?> getCurrentTimeTodo() {
    return dataSource.getCurrentTimeTodo();
  }
}
