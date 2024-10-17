import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future cancelNotification(int id) => _notification.cancel(id);
  static Future cancelAllNotification() => _notification.cancelAll();
  static Future cancelNotificationByTag(String tag) =>
      _notification.cancel(0, tag: tag);

  static Future<void> init({
    bool initScheduled = false,
  }) async {
    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Common initialization settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the plugin
    await _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        print('Notification payload: $payload');
      },
    );
  }

  // Callback when a notification is selected
  static Future selectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');
    }
    // Handle the notification tap action (navigate to a specific page, etc.)
  }

  static Future showNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) =>
      _notification.show(
        id,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
          ),
        ),
        payload: payload,
      );

  static Future scheduledNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required TimeOfDay scheduledDate, 
  }) async {
    print("enter scheduledNotification");
    await _notification.zonedSchedule(
      id,
      title,
      body,
      _scheduledDaily(scheduledDate),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print("finished scheduledNotification");
  }

  static tz.TZDateTime _scheduledDaily(TimeOfDay time) {
    print("enter _scheduledDaily");
    final jakarta = tz.getLocation('Asia/Jakarta');
    tz.setLocalLocation(jakarta);
    final now = tz.TZDateTime.now(jakarta);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute, 0);
    print("before return _scheduledDaily");

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
} 

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _requestNotificationPermission();
  }

  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    if (await Permission.notification.isGranted) {
      print("Notification permission granted");
    } else {
      print("Notification permission denied");
      // Show a dialog or message to inform the user
    }
  }

  static void init() {}
}