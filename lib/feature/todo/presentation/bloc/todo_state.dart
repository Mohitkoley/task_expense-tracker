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
  final Stream<List<TodoModel>> unCompletedtodoList;
  final Stream<List<TodoModel>> completedtodoList;

  TodoLoaded(this.unCompletedtodoList, this.completedtodoList) {
    // Ensure the stream is a broadcast stream to allow multiple listeners
    if (!unCompletedtodoList.isBroadcast) {
      unCompletedtodoList.asBroadcastStream();
    }
    if (!completedtodoList.isBroadcast) {
      completedtodoList.asBroadcastStream();
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => [unCompletedtodoList, completedtodoList];

  //copy with
  TodoLoaded copyWith({
    Stream<List<TodoModel>>? unCompletedtodoList,
    Stream<List<TodoModel>>? completedtodoList,
  }) {
    return TodoLoaded(
      unCompletedtodoList ?? this.unCompletedtodoList,
      completedtodoList ?? this.completedtodoList,
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
