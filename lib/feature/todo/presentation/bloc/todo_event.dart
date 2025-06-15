part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class GetTodoEvent extends TodoEvent {}

final class AddTodoEvent extends TodoEvent {
  final TodoModel expense;

  AddTodoEvent(this.expense);
}

final class DeleteTodoEvent extends TodoEvent {
  final int index;

  DeleteTodoEvent(this.index);
}

final class UpdateTodoEvent extends TodoEvent {
  final int index;
  final TodoModel todo;

  UpdateTodoEvent(this.index, this.todo);
}

final class FilterTodoEvent extends TodoEvent {
  final DateTime date;
  TodoCategory category;

  FilterTodoEvent({
    required this.date,
    this.category = TodoCategory.food,
  });
}
