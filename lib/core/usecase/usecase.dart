import 'package:bloc_test/feature/todo/domain/entity/todo.dart';

abstract interface class UseCase<T, Params> {
  Future<T> call(Params params);
}

abstract interface class UseCaseStream<T, Params> {
  Stream<T> call(Params params);
}

class NoParams {}

class AddExpensesParams {
  final TodoEntity expense;

  AddExpensesParams({required this.expense});
}

class UpdateTodoIndexParams {
  final TodoEntity? expense;

  UpdateTodoIndexParams({this.expense});
}

class FilterTodoParams {
  final DateTime date;
  final TodoCategory category;

  FilterTodoParams({required this.date, required this.category});
}
