import 'package:bloc_test/feature/todo/domain/entity/todo.dart';

abstract interface class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {}

class AddExpensesParams {
  final TodoEntity expense;

  AddExpensesParams({required this.expense});
}

class UpdateTodoIndexParams {
  final int index;
  final TodoEntity? expense;

  UpdateTodoIndexParams({required this.index, this.expense});
}

class FilterTodoParams {
  final DateTime date;
  final TodoCategory category;

  FilterTodoParams({required this.date, required this.category});
}
