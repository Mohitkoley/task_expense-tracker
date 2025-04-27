import 'package:bloc_test/core/export/global_export.dart';

import '../../exports/worktime_balance_export.dart';

@LazySingleton()
class ScheduleNotificationsUseCase {
  final NotificationRepository repository;

  ScheduleNotificationsUseCase(this.repository);

  Future<void> execute(TimeRangeEntity timeRange) {
    return repository.scheduleNotifications(timeRange);
  }
}
