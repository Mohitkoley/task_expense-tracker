part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent extends Equatable {}

final class GetUnCompleteTodoEvent extends TodoEvent {
  List<Object?> get props => [];
}

final class GetCompleteTodoEvent extends TodoEvent {
  List<Object?> get props => [];
}

final class AddTodoEvent extends TodoEvent {
  final TodoModel expense;

  AddTodoEvent(this.expense);

  @override
  List<Object?> get props => [expense];
}

final class DeleteTodoEvent extends TodoEvent {
  final TodoModel todo;

  DeleteTodoEvent(this.todo);

  @override
  // TODO: implement props
  List<Object?> get props => [todo];
}

final class UpdateTodoEvent extends TodoEvent {
  final int index;
  final TodoModel todo;

  UpdateTodoEvent(this.index, this.todo);

  @override
  // TODO: implement props
  List<Object?> get props => [index, todo];
}

final class FilterTodoEvent extends TodoEvent {
  final DateTime date;
  TodoCategory category;

  FilterTodoEvent({
    required this.date,
    this.category = TodoCategory.food,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        date,
        category,
      ];
}
