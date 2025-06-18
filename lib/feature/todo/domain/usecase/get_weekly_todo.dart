import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/weekly_todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllCompleteTodo
    implements UseCaseStream<List<WeeklyTodoModel>, GetWeeklyTodoParams> {
  final TodoRepo repository;

  GetAllCompleteTodo(this.repository);

  @override
  Stream<List<WeeklyTodoModel>> call(GetWeeklyTodoParams params) {
    return repository.getWeeklyTodo(params.date).map((todos) {
      return todos.map((todo) => WeeklyTodoModel.fromTodoModel(todo)).toList();
    });
  }
}
