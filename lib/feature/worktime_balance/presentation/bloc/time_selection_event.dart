import 'package:bloc_test/core/export/global_export.dart';

abstract class TimeSelectionEvent {
  const TimeSelectionEvent();
}

class StartTimeSelected extends TimeSelectionEvent {
  final TimeOfDay time;
  const StartTimeSelected(this.time);
}

class EndTimeSelected extends TimeSelectionEvent {
  final TimeOfDay time;
  const EndTimeSelected(this.time);
}

class ScheduleNotifications extends TimeSelectionEvent {}
