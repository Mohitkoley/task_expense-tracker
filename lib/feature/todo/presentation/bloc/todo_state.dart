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
  final Stream<List<TodoModel>> weeklyTodo;
  final TodoStatus status;
  TodoState(
    Stream<List<TodoModel>> todoList,
    Stream<List<TodoModel>> completedTodo,
    Stream<TodoModel?> currentTimeModel,
    Stream<List<TodoModel>> weeklyTodo,
    this.status,
  )   : unCompletedTodo = todoList.asBroadcastStream(),
        currentTimeTodo = currentTimeModel,
        completedTodo = completedTodo.asBroadcastStream(),
        weeklyTodo = weeklyTodo.asBroadcastStream();

  @override
  // TODO: implement props
  List<Object?> get props =>
      [unCompletedTodo, completedTodo, currentTimeTodo, weeklyTodo];

  //copy with
  TodoState copyWith({
    Stream<List<TodoModel>>? unCompletedtodoList,
    Stream<List<TodoModel>>? completedtodoList,
    Stream<TodoModel?>? currentTimeModel,
    Stream<List<TodoModel>>? weeklyTodo,
    TodoStatus? status,
  }) {
    return TodoState(
      unCompletedtodoList ?? unCompletedTodo,
      completedtodoList ?? completedTodo,
      currentTimeModel ?? currentTimeTodo,
      weeklyTodo ?? this.weeklyTodo,
      status ?? this.status,
    );
  }
}
