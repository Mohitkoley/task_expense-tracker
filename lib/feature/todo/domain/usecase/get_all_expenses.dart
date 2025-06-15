import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/expense_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/assesment_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllExpenses implements UseCase<List<ExpenseModel>, NoParams> {
  final ExpensesRepo repository;

  GetAllExpenses(this.repository);

  @override
  Future<List<ExpenseModel>> call(NoParams params) async {
    final expenses = await repository.getAllExpenses();
    return expenses.map((expense) => ExpenseModel.fromEntity(expense)).toList();
  }
}
