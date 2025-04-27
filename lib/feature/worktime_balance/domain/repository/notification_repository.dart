import '../../exports/worktime_balance_export.dart';

abstract class NotificationRepository {
  Future<void> scheduleNotifications(TimeRangeEntity timeRange);
}
