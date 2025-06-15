import 'package:bloc_test/feature/todo/domain/entity/expense.dart';

abstract interface class ExpensesRepo {
  Future<List<ExpenseEntity>> getAllExpenses();
  Future<List<ExpenseEntity>> addExpenses(ExpenseEntity expenseEntity);
  Future<List<ExpenseEntity>> updateExpense(
      int index, ExpenseEntity expenseEntity);
  Future<List<ExpenseEntity>> deleteExpense(int index);
  Future<List<ExpenseEntity>> filterExpense({
    required DateTime date,
    required ExpenseCategory category,
  });
}
