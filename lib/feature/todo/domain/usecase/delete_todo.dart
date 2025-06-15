import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DeleteExpense implements UseCase<List<TodoModel>, AddExpensesParams> {
  final TodoRepo expenseRepository;

  DeleteExpense({required this.expenseRepository});

  @override
  Future<List<TodoModel>> call(AddExpensesParams params) async {
    final expenses = await expenseRepository.deleteTodo(params.expense);
    return expenses.map((expense) => TodoModel.fromEntity(expense)).toList();
  }
}
