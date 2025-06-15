import 'package:bloc_test/core/constants/notification_const.dart';
import 'package:bloc_test/feature/todo/presentation/screen/add_todo_screen.dart';
import 'package:bloc_test/feature/todo/presentation/screen/todo_homepage.dart';
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
      const DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true);
  static const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');

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

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      // debugPrint('Notification payload: $payload');
      // main();
    }
  }

  static Future scheduleDailyNotification(DateTime selectedTime) async {
    if (selectedTime.isBefore(DateTime.now())) {
      selectedTime = selectedTime.add(const Duration(days: 1));
    }
    final tz.TZDateTime scheduledTime =
        tz.TZDateTime.from(selectedTime, tz.local);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        NotificationConst.intId, // Notification ID
        NotificationConst.title, // Notification title
        NotificationConst.body, // Notification body
        // _nextInstanceOf1130PM(),
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            NotificationConst.id, // Channel ID
            NotificationConst.title, // Channel name
            channelDescription: NotificationConst.channelDescription,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true, // Show alerts
            presentBadge: true, // Update app badge
            presentSound: true, // Play a sound
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: NotificationConst.payload);
  }

  static tz.TZDateTime _nextInstanceOf1130PM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledTime =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 23, 35);

    // If the scheduled time has already passed for today, schedule for tomorrow.
    return scheduledTime.isBefore(now)
        ? scheduledTime.add(const Duration(days: 1))
        : scheduledTime;
  }

  static Future showSimpleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      NotificationConst.id,
      NotificationConst.title,
      channelDescription: 'Daily reminder notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      NotificationConst.title,
      NotificationConst.body,
      platformChannelSpecifics,
      payload: NotificationConst.payload,
    );
  }
}
