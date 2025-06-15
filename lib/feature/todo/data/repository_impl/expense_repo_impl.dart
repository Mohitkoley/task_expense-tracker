import 'package:bloc_test/feature/todo/data/data_source/expense_data_source.dart';
import 'package:bloc_test/feature/todo/data/model/expense_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/expense.dart';
import 'package:bloc_test/feature/todo/domain/repository/assesment_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExpensesRepo)
class ExpensesRepoImpl implements ExpensesRepo {
  final ExpenseDataSource dataSource;

  ExpensesRepoImpl({required this.dataSource});

  @override
  Future<List<ExpenseEntity>> addExpenses(ExpenseEntity expenseEntity) {
    return dataSource.addExpenses(
      ExpenseModel(
        amount: expenseEntity.amount,
        category: expenseEntity.category,
        date: expenseEntity.date,
        description: expenseEntity.description,
      ),
    );
  }

  @override
  Future<List<ExpenseEntity>> deleteExpense(int index) {
    return dataSource.deleteExpense(index);
  }

  @override
  Future<List<ExpenseEntity>> filterExpense(
      {required DateTime date,
      ExpenseCategory category = ExpenseCategory.food}) {
    return dataSource.filterExpense(date: date, category: category);
  }

  @override
  Future<List<ExpenseEntity>> getAllExpenses() {
    return dataSource.getAllExpenses();
  }

  @override
  Future<List<ExpenseEntity>> updateExpense(
      int index, ExpenseEntity expenseEntity) {
    return dataSource.updateExpense(
      index,
      ExpenseModel(
        amount: expenseEntity.amount,
        category: expenseEntity.category,
        date: expenseEntity.date,
        description: expenseEntity.description,
      ),
    );
  }
}
