import 'package:bloc_test/feature/worktime_balance/data/data_source/expense_data_source.dart';
import 'package:bloc_test/feature/worktime_balance/data/model/expense_model.dart';
import 'package:bloc_test/feature/worktime_balance/domain/entity/expense.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExpenseDataSource)
class ExpenseTrackerLocalDataSourceImpl implements ExpenseDataSource {
  final Box<ExpenseModel> box;
  ExpenseTrackerLocalDataSourceImpl(this.box);

  @override
  Future<List<ExpenseModel>> addExpenses(ExpenseModel expenseModel) async {
    try {
      box.add(expenseModel);
    } on Exception {
      rethrow;
    }
    return getAllExpenses();
  }

  @override
  Future<List<ExpenseModel>> deleteExpense(int index) async {
    try {
      box.deleteAt(index);
    } on Exception {
      rethrow;
    }
    return getAllExpenses();
  }

  @override
  Future<List<ExpenseModel>> filterExpense(
      {required DateTime date, required ExpenseCategory category}) async {
    List<ExpenseModel> expenses = [];
    try {
      if (box.isEmpty) {
        return expenses;
      }
      for (int i = 0; i < box.length; i++) {
        if (box.getAt(i).date == date || box.getAt(i).category == category) {
          expenses.add(box.getAt(i));
        }
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return expenses;
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    List<ExpenseModel> expenses = [];
    try {
      if (box.isEmpty) {
        return expenses;
      }
      for (int i = 0; i < box.length; i++) {
        expenses.add(box.getAt(i));
      }
    } on Exception {
      rethrow;
    }
    return expenses;
  }

  @override
  Future<List<ExpenseModel>> updateExpense(
      int index, ExpenseModel expenseEntity) async {
    try {
      box.putAt(index, expenseEntity);
    } on Exception {
      rethrow;
    }
    return getAllExpenses();
  }
}
