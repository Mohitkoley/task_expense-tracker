import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllWeeklyTodo
    implements UseCaseStream<List<TodoModel>, GetWeeklyTodoParams> {
  final TodoRepo repository;

  GetAllWeeklyTodo(this.repository);

  @override
  Stream<List<TodoModel>> call(GetWeeklyTodoParams params) {
    // return repository.getWeeklyTodo(params.date).map((todos) {
    //   return todos.map((todo) => WeeklyTodoModel.fromTodoModel(todo)).toList();
    // });

    return repository.getWeeklyTodo(params.date).map((todos) {
      return todos.map((todo) => TodoModel.fromEntity(todo)).toList();
    });
  }
}
