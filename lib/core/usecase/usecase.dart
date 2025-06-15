import 'package:bloc_test/feature/todo/domain/entity/expense.dart';

abstract interface class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {}

class AddExpensesParams {
  final ExpenseEntity expense;

  AddExpensesParams({required this.expense});
}

class UpdateExpensesIndexParams {
  final int index;
  final ExpenseEntity? expense;

  UpdateExpensesIndexParams({required this.index, this.expense});
}

class FilterExpensesParams {
  final DateTime date;
  final ExpenseCategory category;

  FilterExpensesParams({required this.date, required this.category});
}
