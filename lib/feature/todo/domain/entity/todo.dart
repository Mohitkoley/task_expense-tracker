import 'package:flutter/material.dart';

class TodoEntity {
  final int ID;
  String title;
  DateTime startDateTime;
  DateTime endDateTime;
  String? description;
  Priority priority;
  bool isCompleted;

  TodoEntity({
    required this.ID,
    required this.title,
    required this.startDateTime,
    required this.endDateTime,
    this.description,
    this.priority = Priority.low,
    this.isCompleted = false,
  });
}

enum Priority {
  low,
  medium,
  high;

  String toJson() => name;
  static Priority fromJson(String json) => values.byName(json);
}

extension PriorityExt on Priority {
  Color get color => switch (this) {
        Priority.high => Colors.red,
        Priority.medium => Colors.orange,
        Priority.low => Colors.green,
      };
}
