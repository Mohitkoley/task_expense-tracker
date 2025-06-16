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

part 'todo_event.dart';
part 'todo_state.dart';

@LazySingleton()
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(
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
    on<TodoEvent>(
      getUnCompTodo,
    );
    on<AddTodoEvent>(addTodo);
    on<GetUnCompleteTodoEvent>(
      getUnCompTodo,
    );
    on<GetCompleteTodoEvent>(
      getCompTodo,
    );
    on<UpdateTodoEvent>(
      updateTodo,
    );

    on<DeleteTodoEvent>(
      deleteTodo,
    );
    on<FilterTodoEvent>(
      filterTodo,
    );
  }
  final GetAllUnCompleteTodo _getUnCompleteTodo;
  final GetAllCompleteTodo _getCompleteTodo;
  final UpdateTodo _updateExpenses;
  final DeleteExpense _deleteExpense;
  final FilterTodo _filterExpenses;
  final AddTodos _addExpenses;

  TodoCategory? expenseCategory;

  FutureOr<void> getUnCompTodo(event, emit) async {
    emit(TodoLoading());

    try {
      final expenses = _getUnCompleteTodo(NoParams());
      if (state is TodoLoaded) {
        emit((state as TodoLoaded).copyWith(unCompletedtodoList: expenses));
      }
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  FutureOr<void> getCompTodo(event, emit) async {
    emit(TodoLoading());

    try {
      final expenses = _getCompleteTodo(NoParams());
      if (state is TodoLoaded) {
        emit((state as TodoLoaded).copyWith(completedtodoList: expenses));
      }
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> updateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    try {
      _updateExpenses(UpdateTodoIndexParams(
        index: event.index,
        expense: event.todo,
      ));

      emit(state as TodoLoaded);
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> deleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    try {
      await _deleteExpense(AddExpensesParams(
        expense: event.todo,
      ));
      emit(state as TodoLoaded);
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> filterTodo(
      FilterTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    try {
      await _filterExpenses(FilterTodoParams(
        date: event.date,
        category: event.category,
      ));
      emit(state as TodoLoaded);
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future addTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    try {
      await _addExpenses(AddExpensesParams(
        expense: event.expense,
      ));
      emit(state as TodoLoaded);
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }
}
