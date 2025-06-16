class TodoEntity {
  final int ID;
  String title;
  DateTime startDateTime;
  DateTime endDateTime;
  String? description;
  TodoCategory category;
  bool isCompleted;

  TodoEntity({
    required this.ID,
    required this.title,
    required this.startDateTime,
    required this.endDateTime,
    this.description,
    this.category = TodoCategory.food,
    this.isCompleted = false,
  });
}

enum TodoCategory {
  food,
  transport,
  shopping,
  entertainment,
  health,
  bills,
  others;

  String toJson() => name;
  static TodoCategory fromJson(String json) => values.byName(json);
}
