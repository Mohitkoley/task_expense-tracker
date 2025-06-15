import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/repository/todo_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FilterTodo implements UseCase<List<TodoModel>, FilterTodoParams> {
  FilterTodo({required this.expenseRepository});

  final TodoRepo expenseRepository;
  @override
  Future<List<TodoModel>> call(FilterTodoParams params) async {
    final expenses = await expenseRepository.filterTodo(
        dateTime: params.date, category: params.category);
    return expenses.map((expense) => TodoModel.fromEntity(expense)).toList();
  }
}
