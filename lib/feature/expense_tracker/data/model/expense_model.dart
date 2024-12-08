import 'package:bloc_test/feature/expense_tracker/domain/entity/expense.dart';
import 'package:equatable/equatable.dart';

class ExpenseModel extends ExpenseEntity with EquatableMixin {
  ExpenseModel(
      {required super.amount,
      required super.date,
      super.description,
      super.category});

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      category: ExpenseCategory.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': super.amount,
      'date': super.date.toIso8601String(),
      'description': super.description,
      'category': super.category.toJson(),
    };
  }

  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      amount: entity.amount,
      date: entity.date,
      description: entity.description,
      category: entity.category,
    );
  }

  //copyWith method
  ExpenseModel copyWith({
    int? amount,
    DateTime? date,
    String? description,
    ExpenseCategory? category,
  }) {
    return ExpenseModel(
      amount: amount ?? super.amount,
      date: date ?? super.date,
      description: description ?? super.description,
      category: category ?? super.category,
    );
  }

  @override
  List<Object?> get props =>
      [super.amount, super.date, super.description, super.category];
}
