import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    Future selectNotification(String payload) async {
      //Handle notification tapped logic here!
    }

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0,
        'Hello! It\'s your Plant Pal! 🌱',
        'Some of your plants need watering today!',
        platformChannelSpecifics,
        payload: 'item x');
  }

  scheduleNotification(int daysAdvance) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true);

    DateTime scheduledDay =
        tz.TZDateTime.now(tz.local).add(Duration(days: daysAdvance));
    int id = int.parse(scheduledDay.day.toString() +
        scheduledDay.month.toString() +
        scheduledDay.year.toString());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Hello! It\'s your Plant Pal! 🌱',
        'Some of your plants need watering today!',
        scheduledDay,
        const NotificationDetails(
          android: androidPlatformChannelSpecifics,
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  removeTodaysNotification() async {
    DateTime today = tz.TZDateTime.now(tz.local);
    int id = int.parse(
        today.day.toString() + today.month.toString() + today.year.toString());

    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
