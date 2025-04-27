import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/worktime_balance/data/model/expense_model.dart';
import 'package:bloc_test/feature/worktime_balance/domain/repository/assesment_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DeleteExpense
    implements UseCase<List<ExpenseModel>, UpdateExpensesIndexParams> {
  final ExpensesRepo expenseRepository;

  DeleteExpense({required this.expenseRepository});

  @override
  Future<List<ExpenseModel>> call(UpdateExpensesIndexParams params) async {
    final expenses = await expenseRepository.deleteExpense(params.index);
    return expenses.map((expense) => ExpenseModel.fromEntity(expense)).toList();
  }
}
