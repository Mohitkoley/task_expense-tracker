import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/expense_tracker/data/model/expense_model.dart';
import 'package:bloc_test/feature/expense_tracker/domain/repository/assesment_repo.dart';

class AddExpenses implements UseCase<List<ExpenseModel>, AddExpensesParams> {
  AddExpenses({required this.expenseRepository});

  final ExpensesRepo expenseRepository;
  @override
  Future<List<ExpenseModel>> call(AddExpensesParams params) async {
    final expenses = await expenseRepository.addExpenses(params.expense);
    return expenses.map((expense) => ExpenseModel.fromEntity(expense)).toList();
  }
}
