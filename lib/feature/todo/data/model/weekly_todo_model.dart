import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/weekly_todo.dart';

class WeeklyTodoModel extends WeeklyTodoEntity {
  WeeklyTodoModel({required super.date, required super.todos});

  factory WeeklyTodoModel.fromJson(Map<String, dynamic> json) {
    return WeeklyTodoModel(
      date: DateTime.parse(json['date']),
      todos: (json['todos'] as List<dynamic>)
          .map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory WeeklyTodoModel.fromEntity(WeeklyTodoEntity entity) {
    return WeeklyTodoModel(
      date: entity.date,
      todos: entity.todos.map((e) => TodoModel.fromEntity(e)).toList(),
    );
  }

  factory WeeklyTodoModel.fromTodoModel(WeeklyTodoEntity entity) {
    return WeeklyTodoModel(
      date: entity.date,
      todos: entity.todos.map((e) => TodoModel.fromEntity(e)).toList(),
    );
  }
}
