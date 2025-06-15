import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:equatable/equatable.dart';

class TodoModel extends TodoEntity with EquatableMixin {
  TodoModel(
      {required super.title,
      required super.dateTime,
      super.description,
      super.isCompleted,
      super.category});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
      description: json['description'],
      isCompleted: json['isCompleted'],
      category: TodoCategory.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': super.title,
      'dateTime': super.dateTime.toIso8601String(),
      'description': super.description,
      'isCompleted': super.isCompleted,
      'category': super.category.toJson(),
    };
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      title: entity.title,
      dateTime: entity.dateTime,
      description: entity.description,
      category: entity.category,
      isCompleted: entity.isCompleted,
    );
  }

  //copyWith method
  TodoModel copyWith({
    String? title,
    bool? isCompleted,
    DateTime? dateTime,
    String? description,
    TodoCategory? category,
  }) {
    return TodoModel(
      title: title ?? super.title,
      dateTime: dateTime ?? super.dateTime,
      isCompleted: isCompleted ?? super.isCompleted,
      description: description ?? super.description,
      category: category ?? super.category,
    );
  }

  @override
  List<Object?> get props => [
        super.title,
        super.dateTime,
        super.description,
        super.category,
        super.isCompleted
      ];
}
