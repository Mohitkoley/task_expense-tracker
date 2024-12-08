import 'dart:async';

import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/feature/expense_tracker/data/model/expense_model.dart';
import 'package:bloc_test/feature/expense_tracker/domain/usecase/get_all_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class AssesmentBloc extends Bloc<AssesmentEvent, ExpensesState> {
  AssesmentBloc({required GetAllExpenses getAllCategory})
      : _getImages = getAllCategory,
        super(ExpensesInitial()) {
    on<AssesmentEvent>((event, emit) {});
    on<GetCategory>(
      getCategory,
    );
  }

  FutureOr<void> getCategory(event, emit) async {
    emit(ExpensesLoading());

    try {
      final value = await _getImages(NoParams());
      emit(ExpensesLoaded(value));
    } catch (e) {
      emit(ExpensesErrorState(e.toString()));
    }
  }

  final GetAllExpenses _getImages;
}
