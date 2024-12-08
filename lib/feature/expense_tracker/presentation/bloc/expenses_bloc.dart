import 'dart:async';

import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/expense_tracker/data/model/expense_model.dart';
import 'package:bloc_test/feature/expense_tracker/domain/entity/expense.dart';
import 'package:bloc_test/feature/expense_tracker/domain/usecase/delete_expense.dart';
import 'package:bloc_test/feature/expense_tracker/domain/usecase/filter_expenses.dart';
import 'package:bloc_test/feature/expense_tracker/domain/usecase/get_all_expenses.dart';
import 'package:bloc_test/feature/expense_tracker/domain/usecase/update_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class AssesmentBloc extends Bloc<ExpensesEvent, ExpensesState> {
  AssesmentBloc({
    required GetAllExpenses getAllCategory,
    required GetAllExpenses getAllExpenses,
    required UpdateExpenses updateExpenses,
    required DeleteExpense deleteExpense,
    required FilterExpenses filterExpenses,
  })  : _getExpenses = getAllCategory,
        _updateExpenses = updateExpenses,
        _deleteExpense = deleteExpense,
        _filterExpenses = filterExpenses,
        super(ExpensesInitial()) {
    on<ExpensesEvent>(
      getExpenses,
    );
    on<GetExpensesEvent>(
      getExpenses,
    );
    on<UpdateExpensesEvent>(
      updateExpensesF,
    );
    on<DeleteExpensesEvent>(
      deleteExpenseF,
    );
    on<FilterExpensesEvent>(
      filterExpensesF,
    );
  }
  final GetAllExpenses _getExpenses;

  final UpdateExpenses _updateExpenses;
  final DeleteExpense _deleteExpense;
  final FilterExpenses _filterExpenses;

  FutureOr<void> getExpenses(event, emit) async {
    emit(ExpensesLoading());

    try {
      final expenses = await _getExpenses(NoParams());
      emit(ExpensesLoaded(expenses));
    } catch (e) {
      emit(ExpensesErrorState(e.toString()));
    }
  }

  Future<void> updateExpensesF(
      UpdateExpensesEvent event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());

    try {
      final expenses = await _updateExpenses(UpdateExpensesIndexParams(
        index: event.index,
        expense: event.expense,
      ));
      emit(ExpensesLoaded(expenses));
    } catch (e) {
      emit(ExpensesErrorState(e.toString()));
    }
  }

  Future<void> deleteExpenseF(
      DeleteExpensesEvent event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());

    try {
      final expenses = await _deleteExpense(UpdateExpensesIndexParams(
        index: event.index,
      ));
      emit(ExpensesLoaded(expenses));
    } catch (e) {
      emit(ExpensesErrorState(e.toString()));
    }
  }

  Future<void> filterExpensesF(
      FilterExpensesEvent event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());

    try {
      final expenses = await _filterExpenses(FilterExpensesParams(
        date: event.date,
        category: event.category,
      ));
      emit(ExpensesLoaded(expenses));
    } catch (e) {
      emit(ExpensesErrorState(e.toString()));
    }
  }
}
