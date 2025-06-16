import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllUnCompleteTodo implements UseCaseStream<List<TodoModel>, NoParams> {
  final TodoRepo repository;

  GetAllUnCompleteTodo(this.repository);

  @override
  Stream<List<TodoModel>> call(NoParams params) {
    return repository.getAllUncomplete().map(
          (expenses) =>
              expenses.map((expense) => TodoModel.fromEntity(expense)).toList(),
        );
  }
}
