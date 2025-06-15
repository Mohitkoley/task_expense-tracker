import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:isar/isar.dart';

part 'todo_model.g.dart';

@collection
@Name('todo')
class TodoModel extends TodoEntity {
  TodoModel(
      {required this.id,
      required this.kTitle,
      required this.kDateTime,
      this.kDescription,
      this.kIsCompleted = false,
      required this.kCategory})
      : super(
          ID: id,
          title: kTitle,
          dateTime: kDateTime,
          description: kDescription,
          isCompleted: kIsCompleted,
          category: kCategory,
        );

  final int id;
  @Index(name: 'title')
  final String kTitle;
  @Index(name: 'description')
  String? kDescription;
  @Index(name: 'dateTime')
  final DateTime kDateTime;
  @Index(name: 'isCompleted')
  bool kIsCompleted;
  @Index(name: 'category')
  final TodoCategory kCategory;

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      kTitle: json['title'],
      kDateTime: DateTime.parse(json['dateTime']),
      kDescription: json['description'],
      kIsCompleted: json['isCompleted'],
      kCategory: TodoCategory.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': super.title,
      'dateTime': super.dateTime.toIso8601String(),
      'description': super.description,
      'isCompleted': super.isCompleted,
      'category': super.category.toJson(),
    };
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.ID,
      kTitle: entity.title,
      kDateTime: entity.dateTime,
      kDescription: entity.description,
      kCategory: entity.category,
      kIsCompleted: entity.isCompleted,
    );
  }

  //copyWith method
  TodoModel copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    DateTime? dateTime,
    String? description,
    TodoCategory? category,
  }) {
    return TodoModel(
      id: id ?? this.id,
      kTitle: title ?? kTitle,
      kDateTime: dateTime ?? kDateTime,
      kIsCompleted: isCompleted ?? kIsCompleted,
      kDescription: description ?? kDescription,
      kCategory: category ?? kCategory,
    );
  }
}
