import 'package:bloc_test/core/service/notification/local_notification_service.dart';
import 'package:bloc_test/feature/todo/data/data_source/todo_data_source.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/data/model/weekly_todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/domain/entity/weekly_todo.dart';
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
      Kpriority: todoEntity.priority,
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
      Kpriority: todoEntity.priority,
      kStartDateTime: todoEntity.startDateTime,
      kIsCompleted: todoEntity.isCompleted,
      kDescription: todoEntity.description,
    );
    FlutterLocalNotiServices.removeScheduleTodoNotification(todoModel);
    return dataSource.deleteTodos(todoModel);
  }

  @override
  Future<List<TodoEntity>> filterTodo(
      {required DateTime dateTime, Priority category = Priority.low}) {
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
      Kpriority: expenseEntity.priority,
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

  @override
  Stream<List<WeeklyTodoEntity>> getWeeklyTodo(DateTime date) {
    Stream<List<TodoModel>> todoStream = dataSource.getWeeklyTodos(date);
    return todoStream.map((todos) {
      final Map<DateTime, List<TodoModel>> groupedMap = {};

      for (final todo in todos) {
        final date = DateTime(todo.startDateTime.year, todo.startDateTime.month,
            todo.startDateTime.day);
        groupedMap.putIfAbsent(date, () => []).add(todo);
      }

      // Sort each day's todos
      for (final list in groupedMap.values) {
        list.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
      }

      // Convert to list of WeeklyTodoModel and sort by date
      final weeklyTodos = groupedMap.entries.map((entry) {
        return WeeklyTodoModel(date: entry.key, todos: entry.value);
      }).toList()
        ..sort((a, b) => a.date.compareTo(b.date));

      return weeklyTodos;
    });
  }
}
