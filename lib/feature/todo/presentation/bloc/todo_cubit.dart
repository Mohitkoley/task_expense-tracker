import 'dart:async';

import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/add_todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/delete_todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/filter_todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/get_all_complete_todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/get_all_uncomplete_todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/update_todo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// part 'todo_event.dart';
part 'todo_state.dart';

@LazySingleton()
class TodoCubit extends Cubit<TodoState> {
  TodoCubit(
      {required AddTodos addExpenses,
      required GetAllUnCompleteTodo getAllUnCompletedTodo,
      required UpdateTodo updateExpenses,
      required DeleteExpense deleteExpense,
      required FilterTodo filterExpenses,
      required GetAllCompleteTodo getAllCompletedTodo})
      : _getUnCompleteTodo = getAllUnCompletedTodo,
        _updateExpenses = updateExpenses,
        _deleteExpense = deleteExpense,
        _filterExpenses = filterExpenses,
        _addExpenses = addExpenses,
        _getCompleteTodo = getAllCompletedTodo,
        super(TodoInitial()) {
    // on<TodoEvent>(
    //   getUnCompTodo,
    // );
    // on<AddTodoEvent>(addTodo);
    // on<GetUnCompleteTodoEvent>(
    //   getUnCompTodo,
    // );
    // on<GetCompleteTodoEvent>(
    //   getCompTodo,
    // );
    // on<UpdateTodoEvent>(
    //   updateTodo,
    // );

    // on<DeleteTodoEvent>(
    //   deleteTodo,
    // );
    // on<FilterTodoEvent>(
    //   filterTodo,
    // );
  }
  final GetAllUnCompleteTodo _getUnCompleteTodo;
  final GetAllCompleteTodo _getCompleteTodo;
  final UpdateTodo _updateExpenses;
  final DeleteExpense _deleteExpense;
  final FilterTodo _filterExpenses;
  final AddTodos _addExpenses;

  TodoCategory? expenseCategory;

  FutureOr<void> getAllTodo() async {
    try {
      final todos = _getUnCompleteTodo(NoParams());
      final todoUnCompleted = _getCompleteTodo(NoParams());
      emit(TodoLoaded(todos, todoUnCompleted));
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  // FutureOr<void> getCompTodo(emit) async {
  //   try {
  //     final expenses = _getCompleteTodo(NoParams());
  //     if (state is TodoLoaded) {
  //       emit((state as TodoLoaded));
  //     } else {
  //       emit(TodoLoaded(expenses));
  //     }
  //   } catch (e) {
  //     emit(TodoErrorState(e.toString()));
  //   }
  // }

  Future<void> updateTodo(TodoModel todo) async {
    try {
      _updateExpenses(
        UpdateTodoIndexParams(
          expense: todo,
        ),
      );

      emit(state as TodoLoaded);
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> deleteTodo(
    TodoModel todo,
  ) async {
    try {
      await _deleteExpense(AddExpensesParams(
        expense: todo,
      ));
      emit(state as TodoLoaded);
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> filterTodo(
      DateTime date, TodoCategory category, Emitter<TodoState> emit) async {
    try {
      await _filterExpenses(FilterTodoParams(
        date: date,
        category: category,
      ));
      emit(state as TodoLoaded);
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future addTodo(TodoModel todo) async {
    try {
      await _addExpenses(AddExpensesParams(
        expense: todo,
      ));
      emit(state as TodoLoaded);
    } catch (e) {
      debugPrint(e.toString());
      emit(TodoErrorState(e.toString()));
    }
  }
}
