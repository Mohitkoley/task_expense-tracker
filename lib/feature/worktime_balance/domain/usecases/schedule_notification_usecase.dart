import '../../exports/worktime_balance_export.dart';

class ScheduleNotificationsUseCase {
  final NotificationRepository repository;

  ScheduleNotificationsUseCase(this.repository);

  Future<void> execute(TimeRangeEntity timeRange) {
    return repository.scheduleNotifications(timeRange);
  }
}
