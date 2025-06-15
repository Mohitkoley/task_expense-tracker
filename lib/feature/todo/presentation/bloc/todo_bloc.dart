import 'dart:async';

import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/add_todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/delete_todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/filter_todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/get_all_todo.dart';
import 'package:bloc_test/feature/todo/domain/usecase/update_todo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

@named
@LazySingleton()
class ExpensesBloc extends Bloc<TodoEvent, TodoExpensesState> {
  ExpensesBloc({
    required AddTodos addExpenses,
    required GetAllTodo getAllExpenses,
    required UpdateTodo updateExpenses,
    required DeleteExpense deleteExpense,
    required FilterTodo filterExpenses,
  })  : _getExpenses = getAllExpenses,
        _updateExpenses = updateExpenses,
        _deleteExpense = deleteExpense,
        _filterExpenses = filterExpenses,
        _addExpenses = addExpenses,
        super(TodoInitial()) {
    on<TodoEvent>(
      getTodo,
    );
    on<AddTodoEvent>(addExpenseF);
    on<GetTodoEvent>(
      getTodo,
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
  final GetAllTodo _getExpenses;

  final UpdateTodo _updateExpenses;
  final DeleteExpense _deleteExpense;
  final FilterTodo _filterExpenses;
  final AddTodos _addExpenses;

  TodoCategory? expenseCategory;

  FutureOr<void> getTodo(event, emit) async {
    emit(TodoLoading());

    try {
      final expenses = await _getExpenses(NoParams());
      emit(TodoLoaded(expenses));
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> updateTodo(
      UpdateTodoEvent event, Emitter<TodoExpensesState> emit) async {
    emit(TodoLoading());

    try {
      final expenses = await _updateExpenses(UpdateTodoIndexParams(
        index: event.index,
        expense: event.todo,
      ));
      emit(TodoLoaded(expenses));
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> deleteTodo(
      DeleteTodoEvent event, Emitter<TodoExpensesState> emit) async {
    emit(TodoLoading());

    try {
      final expenses = await _deleteExpense(UpdateTodoIndexParams(
        index: event.index,
      ));
      emit(TodoLoaded(expenses));
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> filterTodo(
      FilterTodoEvent event, Emitter<TodoExpensesState> emit) async {
    emit(TodoLoading());

    try {
      final expenses = await _filterExpenses(FilterTodoParams(
        date: event.date,
        category: event.category,
      ));
      emit(TodoLoaded(expenses));
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future addExpenseF(
      AddTodoEvent event, Emitter<TodoExpensesState> emit) async {
    emit(TodoLoading());

    try {
      final expenses = await _addExpenses(AddExpensesParams(
        expense: event.expense,
      ));
      emit(TodoLoaded(expenses));
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }
}
