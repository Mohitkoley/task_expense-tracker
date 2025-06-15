import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllUnCompleteTodo implements UseCase<List<TodoModel>, NoParams> {
  final TodoRepo repository;

  GetAllUnCompleteTodo(this.repository);

  @override
  Future<List<TodoModel>> call(NoParams params) async {
    final expenses = await repository.getAllUncomplete();
    return expenses.map((expense) => TodoModel.fromEntity(expense)).toList();
  }
}
