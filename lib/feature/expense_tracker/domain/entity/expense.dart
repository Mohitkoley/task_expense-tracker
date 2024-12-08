class ExpenseEntity {
  int amount;
  DateTime date;
  String? description;
  ExpenseCategory category;

  ExpenseEntity({
    required this.amount,
    required this.date,
    this.description,
    this.category = ExpenseCategory.food,
  });
}

enum ExpenseCategory {
  food,
  transport,
  shopping,
  entertainment,
  health,
  bills,
  others;

  String toJson() => name;
  static ExpenseCategory fromJson(String json) => values.byName(json);
}
