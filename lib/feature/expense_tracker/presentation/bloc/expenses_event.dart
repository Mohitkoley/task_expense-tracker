part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesEvent {}

final class GetExpensesEvent extends ExpensesEvent {}

final class AddExpensesEvent extends ExpensesEvent {
  final ExpenseModel expense;

  AddExpensesEvent(this.expense);
}

final class DeleteExpensesEvent extends ExpensesEvent {
  final int index;

  DeleteExpensesEvent(this.index);
}

final class UpdateExpensesEvent extends ExpensesEvent {
  final int index;
  final ExpenseModel expense;

  UpdateExpensesEvent(this.index, this.expense);
}

final class FilterExpensesEvent extends ExpensesEvent {
  final DateTime date;
  final ExpenseCategory category;

  FilterExpensesEvent(this.date, this.category);
}
