import 'package:bloc_test/core/export/global_export.dart';

class TimeSelectionState {
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool isLoading;
  final String? error;

  TimeSelectionState({
    this.startTime,
    this.endTime,
    this.isLoading = false,
    this.error,
  });

  TimeSelectionState copyWith({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isLoading,
    String? error,
  }) {
    return TimeSelectionState(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
