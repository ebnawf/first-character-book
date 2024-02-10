import 'package:first_character_book/screen/poem_screen.dart';
import 'package:first_character_book/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = "1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    channelId,
    "ديوان الحرف الاول",
    channelDescription:
        "This channel is responsible for all the local notifications",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  static const DarwinNotificationDetails _iOSNotificationDetails =
      DarwinNotificationDetails();

  final NotificationDetails notificationDetails = const NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iOSNotificationDetails,
  );

  Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/notification');

    const DarwinInitializationSettings iOSInitializationSettings =
        DarwinInitializationSettings(
      defaultPresentAlert: false,
      defaultPresentBadge: false,
      defaultPresentSound: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    // *** Initialize timezone here ***
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
    requestIOSPermissions();
    requestAndroidSPermissions();
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> requestAndroidSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showNotification(
      int id, String title, String body, String payload) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> scheduleNew() async {
    await cancelAllNotifications();
    var poem = await DbHelper.getRandomSuggestedPoem();
    if (poem != null) {
      await scheduleNotification(
          poem.id,
          "مقترحة لك ",
          'دعوة لمطالعة قصيدة ${poem.title} من باب ${poem.chapter}',
          poem.id.toString());
    }
  }

  Future<void> scheduleNotification(
      int id, String title, String body, String payload) async {
    final now = DateTime.now();
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.UTC,
      now.year,
      now.month,
      now.day,
      11,
      30,
    );
    scheduledDate = scheduledDate.add(const Duration(days: 3));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future<void> onSelectNotification(
    NotificationResponse? notificationResponse) async {
  final id = int.parse(notificationResponse!.payload!);
  var poem = await DbHelper.getPoemById(id);
  await navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (_) => PoemScreen(
                poem: poem,
              )),
      (Route<dynamic> root) => false);
}
