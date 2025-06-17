part of 'todo_cubit.dart';

// final class TodoInitial extends TodoState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

// final class TodoLoading extends TodoState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

enum TodoStatus {
  initial,
  loading,
  loaded,
  error,
}

final class TodoState extends Equatable {
  final Stream<TodoModel?> currentTimeTodo;
  final Stream<List<TodoModel>> unCompletedTodo;
  final Stream<List<TodoModel>> completedTodo;
  final TodoStatus status;
  TodoState(
    Stream<List<TodoModel>> todoList,
    Stream<List<TodoModel>> completedTodo,
    Stream<TodoModel?> currentTimeModel,
    this.status,
  )   : unCompletedTodo = todoList.asBroadcastStream(),
        currentTimeTodo = currentTimeModel,
        completedTodo = completedTodo.asBroadcastStream();

  @override
  // TODO: implement props
  List<Object?> get props => [unCompletedTodo, completedTodo, currentTimeTodo];

  //copy with
  TodoState copyWith({
    Stream<List<TodoModel>>? unCompletedtodoList,
    Stream<List<TodoModel>>? completedtodoList,
    Stream<TodoModel?>? currentTimeModel,
    TodoStatus? status,
  }) {
    return TodoState(
      unCompletedtodoList ?? unCompletedTodo,
      completedtodoList ?? completedTodo,
      currentTimeModel ?? currentTimeTodo,
      status ?? this.status,
    );
  }
}
