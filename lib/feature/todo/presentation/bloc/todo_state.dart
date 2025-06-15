part of 'todo_bloc.dart';

@immutable
sealed class TodoState extends Equatable {}

final class TodoInitial extends TodoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class TodoLoading extends TodoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class TodoLoaded extends TodoState {
  final List<TodoModel> todoList;

  TodoLoaded(this.todoList);

  @override
  // TODO: implement props
  List<Object?> get props => [todoList];
}

final class TodoErrorState extends TodoState {
  final String message;

  TodoErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
