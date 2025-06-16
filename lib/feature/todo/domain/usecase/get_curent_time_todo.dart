import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetCurrentTimetodo implements UseCaseStream<TodoModel?, NoParams> {
  final TodoRepo repository;

  GetCurrentTimetodo(this.repository);

  @override
  Stream<TodoModel?> call(NoParams params) async* {
    final todo = repository.getCurrentTimeTodo();
    yield* todo.map((todo) => todo != null ? TodoModel.fromEntity(todo) : null);
  }
}
