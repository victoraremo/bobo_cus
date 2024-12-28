import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
  // Add request permission
  await _notification.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
      
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  // Add onDidReceiveNotificationResponse callback
  await _notification.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse details) {
      // Handle notification tap
      print('Notification clicked');
    },
  );
  
  tz.initializeTimeZones();
}

  static Future<void> scheduleNotification(
  String title,
  String body,
  int userDayInput,
) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'scheduled_channel_id',
    'Scheduled Notifications',
    channelDescription: 'Channel for scheduled notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  final scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(seconds: userDayInput));
  
  await _notification.zonedSchedule(
    0,
    title,
    body,
    scheduledTime,
    notificationDetails,
    // androidAllowWhileIdle: true,  // Enable exact timing
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );
}
  static Future<void> showNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'your_channel_id',  // Unique channel ID
    'your_channel_name', // Channel name
    channelDescription: 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await _notification.show(
    1,
    'Winner 😘🏆',
    'Call ☎️ 7721900 for more details',
    notificationDetails,
  );
}
  static Future<void> cancelAllNotifications() async {
    await _notification.cancelAll();
  }
}

// tz.TZDateTime.now(tz.local).add(Duration(seconds: userDayInput)),