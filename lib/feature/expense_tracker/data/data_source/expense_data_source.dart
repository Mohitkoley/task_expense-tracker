import 'package:bloc_test/feature/expense_tracker/data/model/expense_model.dart';
import 'package:bloc_test/feature/expense_tracker/domain/entity/expense.dart';

abstract interface class ExpenseDataSource {
  Future<List<ExpenseModel>> getAllExpenses();
  Future<List<ExpenseModel>> addExpenses(ExpenseModel expenseEntity);
  Future<List<ExpenseModel>> updateExpense(
      int index, ExpenseModel expenseModel);
  Future<List<ExpenseModel>> deleteExpense(int index);
  Future<List<ExpenseModel>> filterExpense({
    required DateTime date,
    required ExpenseCategory category,
  });
}
