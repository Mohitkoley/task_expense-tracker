import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports/worktime_balance_export.dart';

class TimeSelectionBloc extends Bloc<TimeSelectionEvent, TimeSelectionState> {
  final ScheduleNotificationsUseCase scheduleNotificationsUseCase;

  TimeSelectionBloc({required this.scheduleNotificationsUseCase})
      : super(TimeSelectionState()) {
    on<StartTimeSelected>(_onStartTimeSelected);
    on<EndTimeSelected>(_onEndTimeSelected);
    on<ScheduleNotifications>(_onScheduleNotifications);
  }

  void _onStartTimeSelected(
    StartTimeSelected event,
    Emitter<TimeSelectionState> emit,
  ) {
    emit(state.copyWith(startTime: event.time));
  }

  void _onEndTimeSelected(
    EndTimeSelected event,
    Emitter<TimeSelectionState> emit,
  ) {
    emit(state.copyWith(endTime: event.time));
  }

  Future<void> _onScheduleNotifications(
    ScheduleNotifications event,
    Emitter<TimeSelectionState> emit,
  ) async {
    if (state.startTime == null || state.endTime == null) {
      emit(state.copyWith(error: 'Please select both times'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final timeRange = TimeRangeEntity(
        startTime: _combineTime(state.startTime!),
        endTime: _combineTime(state.endTime!),
      );

      await scheduleNotificationsUseCase.execute(timeRange);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to schedule notifications',
      ));
    }
  }

  DateTime _combineTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }
}
