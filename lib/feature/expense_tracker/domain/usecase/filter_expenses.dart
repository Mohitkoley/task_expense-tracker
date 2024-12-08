import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/expense_tracker/data/model/expense_model.dart';
import 'package:bloc_test/feature/expense_tracker/domain/repository/assesment_repo.dart';

class FilterExpenses
    implements UseCase<List<ExpenseModel>, FilterExpensesParams> {
  FilterExpenses({required this.expenseRepository});

  final ExpensesRepo expenseRepository;
  @override
  Future<List<ExpenseModel>> call(FilterExpensesParams params) async {
    final expenses = await expenseRepository.filterExpense(
        date: params.date, category: params.category);
    return expenses.map((expense) => ExpenseModel.fromEntity(expense)).toList();
  }
}
