part of 'todo_cubit.dart';

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
  final Stream<TodoModel?> currentTimeTodo;
  final Stream<List<TodoModel>> unCompletedTodo;
  final Stream<List<TodoModel>> completedTodo;
  TodoLoaded(
      Stream<List<TodoModel>> todoList,
      Stream<List<TodoModel>> completedTodo,
      Stream<TodoModel?> currentTimeModel)
      : unCompletedTodo = todoList.asBroadcastStream(),
        currentTimeTodo = currentTimeModel,
        completedTodo = completedTodo.asBroadcastStream();

  @override
  // TODO: implement props
  List<Object?> get props => [unCompletedTodo, completedTodo, currentTimeTodo];

  //copy with
  TodoLoaded copyWith({
    Stream<List<TodoModel>>? unCompletedtodoList,
    Stream<List<TodoModel>>? completedtodoList,
    Stream<TodoModel?>? currentTimeModel,
  }) {
    return TodoLoaded(
      unCompletedtodoList ?? unCompletedTodo,
      completedtodoList ?? completedTodo,
      currentTimeModel ?? currentTimeTodo,
    );
  }
}

final class TodoErrorState extends TodoState {
  final String message;

  TodoErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
