import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:isar/isar.dart';

part 'todo_model.g.dart';

@collection
@Name('todo')
class TodoModel extends TodoEntity {
  TodoModel(
      {required this.id,
      required this.kTitle,
      required this.kStartDateTime,
      required this.kEndDateTime,
      this.kDescription,
      this.kIsCompleted = false,
      required this.Kpriority})
      : super(
          ID: id,
          title: kTitle,
          startDateTime: kStartDateTime,
          description: kDescription,
          isCompleted: kIsCompleted,
          priority: Kpriority,
          endDateTime: kEndDateTime,
        );

  final int id;
  @Index(name: 'title')
  final String kTitle;
  @Index(name: 'description')
  String? kDescription;
  @Index(name: 'startDateTime')
  final DateTime kStartDateTime;
  @Index(name: 'endDateTime')
  final DateTime kEndDateTime;
  @Index(name: 'isCompleted')
  bool kIsCompleted;
  @Index(name: 'priority')
  final Priority Kpriority;

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      kTitle: json['title'],
      kStartDateTime: DateTime.parse(json['startDateTime']),
      kEndDateTime: DateTime.parse(json['endDateTime']),
      kDescription: json['description'],
      kIsCompleted: json['isCompleted'],
      Kpriority: Priority.fromJson(json['priority']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': super.title,
      'dateTime': super.startDateTime.toIso8601String(),
      'description': super.description,
      'isCompleted': super.isCompleted,
      'category': super.priority.toJson(),
    };
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.ID,
      kEndDateTime: entity.endDateTime,
      kTitle: entity.title,
      kStartDateTime: entity.startDateTime,
      kDescription: entity.description,
      Kpriority: entity.priority,
      kIsCompleted: entity.isCompleted,
    );
  }

  //copyWith method
  TodoModel copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? description,
    Priority? kpriority,
  }) {
    return TodoModel(
      id: id ?? this.id,
      kTitle: title ?? kTitle,
      kStartDateTime: startDateTime ?? kStartDateTime,
      kEndDateTime: endDateTime ?? kEndDateTime,
      kIsCompleted: isCompleted ?? kIsCompleted,
      kDescription: description ?? kDescription,
      Kpriority: priority ?? Kpriority,
    );
  }

  TodoEntity toEntity() {
    return TodoEntity(
      ID: id,
      title: kTitle,
      startDateTime: kStartDateTime,
      endDateTime: kEndDateTime,
      description: kDescription,
      isCompleted: kIsCompleted,
      priority: Kpriority,
    );
  }
}
