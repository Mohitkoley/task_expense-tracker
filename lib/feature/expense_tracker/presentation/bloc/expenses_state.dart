part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesState {}

final class ExpensesInitial extends ExpensesState {}

final class ExpensesLoading extends ExpensesState {}

final class ExpensesLoaded extends ExpensesState {
  final List<ExpenseModel> categoryList;

  ExpensesLoaded(this.categoryList);
}

final class ExpensesErrorState extends ExpensesState {
  final String message;

  ExpensesErrorState(this.message);
}
