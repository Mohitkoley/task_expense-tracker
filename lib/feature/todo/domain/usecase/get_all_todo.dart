import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllTodo implements UseCase<List<TodoModel>, NoParams> {
  final TodoRepo repository;

  GetAllTodo(this.repository);

  @override
  Future<List<TodoModel>> call(NoParams params) async {
    final expenses = await repository.getAllTodos();
    return expenses.map((expense) => TodoModel.fromEntity(expense)).toList();
  }
}
