import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllCompleteTodo implements UseCaseStream<List<TodoModel>, NoParams> {
  final TodoRepo repository;

  GetAllCompleteTodo(this.repository);

  @override
  Stream<List<TodoModel>> call(NoParams params) {
    return repository.getAllComplete().map(
          (expenses) =>
              expenses.map((expense) => TodoModel.fromEntity(expense)).toList(),
        );
  }
}
