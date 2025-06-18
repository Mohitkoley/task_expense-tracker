import 'package:bloc_test/feature/todo/domain/entity/todo.dart';

class WeeklyTodoEntity {
  final DateTime date;

  final List<TodoEntity> todos;

  const WeeklyTodoEntity({
    required this.date,
    required this.todos,
  });
}
