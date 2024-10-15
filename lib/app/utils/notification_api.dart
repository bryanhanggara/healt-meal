import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future init({bool initSchedule = false}) async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);
    await _notification.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) async {
        print('notification payload: $payload');
      },
    );
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
          payload: payload);

  static Future cancelNotification(int id) => _notification.cancel(id);
  static Future cancelAllNotificaation(int id) => _notification.cancelAll();
  static Future cancelNotificationByTag(String tag) =>
      _notification.cancel(0, tag: tag);

  static tz.TZDateTime _scheduleDaily(TimeOfDay time) {
    final jakarta = tz.getLocation('Asia/Jakarta');
    tz.setLocalLocation(jakarta);
    final now = tz.TZDateTime.now(jakarta);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return scheduleDate.isBefore(now)
        ? scheduleDate = scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }

  static Future scheduleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required TimeOfDay scheduleDate,
  }) async {
    _notification.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(scheduleDate),
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
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
          matchDateTimeComponents: DateTimeComponents.time
    );
  }
}
