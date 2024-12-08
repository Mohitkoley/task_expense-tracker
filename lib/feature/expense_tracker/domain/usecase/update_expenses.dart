import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/expense_tracker/data/model/expense_model.dart';
import 'package:bloc_test/feature/expense_tracker/domain/repository/assesment_repo.dart';

class UpdateExpenses
    implements UseCase<List<ExpenseModel>, UpdateExpensesIndexParams> {
  UpdateExpenses({required this.expenseRepository});

  final ExpensesRepo expenseRepository;
  @override
  Future<List<ExpenseModel>> call(UpdateExpensesIndexParams params) async {
    final expenses =
        await expenseRepository.updateExpense(params.index, params.expense!);
    return expenses.map((expense) => ExpenseModel.fromEntity(expense)).toList();
  }
}
