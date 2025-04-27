import 'package:bloc_test/core/constants/notification_const.dart';
import 'package:bloc_test/feature/expense_tracker/presentation/screen/add_expenses_screen.dart';
import 'package:bloc_test/feature/expense_tracker/presentation/screen/expenses_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FlutterLocalNotiServices {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  static AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  static DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          notificationCategories: <DarwinNotificationCategory>[
        DarwinNotificationCategory(
          'daily_notification_channel',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            DarwinNotificationAction.plain(
              'id_3',
              'Action 3',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        )
      ],
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true);
  static const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  static WindowsInitializationSettings initializationSettingsWindows =
      const WindowsInitializationSettings(
          appName: 'Flutter Local Notification',
          appUserModelId: 'Com.Dexterous.FlutterLocalNotificationsExample',
          // Search online for GUID generators to make your own
          guid: 'd49b0314-ee7a-4626-bf79-97cdb8a991bb');

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  static Future askNotificationPermission() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTapNotification,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    tz.initializeTimeZones();
    // scheduleDailyNotification();
  }

  static void onTapNotification(
      NotificationResponse notificationResponse) async {
    debugPrint(
        'Notification tapped with payload: ${notificationResponse.payload}');
    if (NotificationConst.payload == notificationResponse.payload) {
      //open app
      // main();
      await Navigator.push(
        ExpensesHomepage.openContext,
        MaterialPageRoute<void>(
            builder: (context) => const AddExpensesScreen()),
      );
    }
  }

  static Future<void> get showNotificationWithActions async =>
      _showNotificationWithActions();

  static Future<void> _showNotificationWithActions() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '...',
      '...',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('id_1', 'Action 1'),
        AndroidNotificationAction('id_2', 'Action 2'),
        AndroidNotificationAction('id_3', 'Action 3'),
      ],
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        0, '...', '...', notificationDetails);
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) async {
    debugPrint(
        'Background notification tapped with payload: ${notificationResponse.payload}');

    if (notificationResponse.payload == NotificationConst.payload) {
      await Navigator.push(
        ExpensesHomepage.openContext,
        MaterialPageRoute<void>(
            builder: (context) => const AddExpensesScreen()),
      );
    }
  }

  Future<void> scheduleNotifications({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final times = _calculateNotificationTimes(startTime, endTime);

    for (int i = 0; i < times.length; i++) {
      await _scheduleNotification(
        id: i,
        title: 'Reminder',
        body: 'Notification at ${times[i].hour}:${times[i].minute}',
        scheduledTime: times[i],
      );
    }
  }

  List<DateTime> _calculateNotificationTimes(DateTime start, DateTime end) {
    List<DateTime> times = [];
    DateTime current = _getFirstNotificationTime(start);

    while (current.isBefore(end)) {
      times.add(current);
      current = current.add(const Duration(hours: 1));
    }

    return times;
  }

  DateTime _getFirstNotificationTime(DateTime start) {
    if (start.minute < 45) {
      return DateTime(start.year, start.month, start.day, start.hour, 45);
    }
    return DateTime(start.year, start.month, start.day, start.hour + 1, 45);
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    if (scheduledTime.isBefore(DateTime.now())) return;

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'channel_id', 'Scheduled Notifications',
            importance: Importance.max, priority: Priority.high),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // uiLocalNotificationDateInterpretation:
    );
  }
}

  // void onDidReceiveNotificationResponse(
  //     NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (payload != null) {
  //     // debugPrint('Notification payload: $payload');
  //     // main();
  //   }
  // }

  // static Future scheduleDailyNotification(DateTime selectedTime) async {
  //   if (selectedTime.isBefore(DateTime.now())) {
  //     selectedTime = selectedTime.add(const Duration(days: 1));
  //   }
  //   final tz.TZDateTime scheduledTime =
  //       tz.TZDateTime.from(selectedTime, tz.local);
  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //       NotificationConst.intId, // Notification ID
  //       NotificationConst.title, // Notification title
  //       NotificationConst.body, // Notification body
  //       // _nextInstanceOf1130PM(),
  //       scheduledTime,
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           NotificationConst.id, // Channel ID
  //           NotificationConst.title, // Channel name
  //           channelDescription: NotificationConst.channelDescription,
  //           importance: Importance.high,
  //           priority: Priority.high,
  //         ),
  //         iOS: DarwinNotificationDetails(
  //           presentAlert: true, // Show alerts
  //           presentBadge: true, // Update app badge
  //           presentSound: true, // Play a sound
  //         ),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       matchDateTimeComponents: DateTimeComponents.time,
  //       payload: NotificationConst.payload);
  // }

  // static tz.TZDateTime _nextInstanceOf1130PM() {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   final tz.TZDateTime scheduledTime =
  //       tz.TZDateTime(tz.local, now.year, now.month, now.day, 23, 35);

  //   // If the scheduled time has already passed for today, schedule for tomorrow.
  //   return scheduledTime.isBefore(now)
  //       ? scheduledTime.add(const Duration(days: 1))
  //       : scheduledTime;
  // }

  // static Future showSimpleNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     NotificationConst.id,
  //     NotificationConst.title,
  //     channelDescription: 'Daily reminder notifications',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     showWhen: false,
  //   );
  //   const DarwinNotificationDetails iOSPlatformChannelSpecifics =
  //       DarwinNotificationDetails(
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);
  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     NotificationConst.title,
  //     NotificationConst.body,
  //     platformChannelSpecifics,
  //     payload: NotificationConst.payload,
  //   );
  // } }


  
