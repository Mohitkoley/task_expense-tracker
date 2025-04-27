import 'package:bloc_test/core/notification/local_notification_service.dart';

import '../../exports/worktime_balance_export.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotiServices notificationService;

  NotificationRepositoryImpl({required this.notificationService});

  @override
  Future<void> scheduleNotifications(TimeRangeEntity timeRange) async {
    await notificationService.scheduleNotifications(
      startTime: timeRange.startTime,
      endTime: timeRange.endTime,
    );
  }
}
