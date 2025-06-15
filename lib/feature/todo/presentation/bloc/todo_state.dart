part of 'todo_bloc.dart';

@immutable
sealed class TodoExpensesState extends Equatable {}

final class TodoInitial extends TodoExpensesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class TodoLoading extends TodoExpensesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class TodoLoaded extends TodoExpensesState {
  final List<TodoModel> categoryList;

  TodoLoaded(this.categoryList);

  @override
  // TODO: implement props
  List<Object?> get props => [categoryList];
}

final class TodoErrorState extends TodoExpensesState {
  final String message;

  TodoErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
