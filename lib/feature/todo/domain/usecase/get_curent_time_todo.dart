import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetCurrentTimetodo
    implements UseCaseStream<Either<TodoModel?, TodoModel?>, NoParams> {
  final TodoRepo repository;

  GetCurrentTimetodo(this.repository);

  @override
  Stream<Either<TodoModel?, TodoModel?>> call(NoParams params) {
    return repository.getCurrentTimeTodo().map((either) => either.fold(
        ifLeft: (todoEntity) =>
            Left(todoEntity != null ? TodoModel.fromEntity(todoEntity) : null),
        ifRight: (todoEntity) => Right(
            todoEntity != null ? TodoModel.fromEntity(todoEntity) : null)));
  }
}
