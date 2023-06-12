import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo');
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            sound: RawResourceAndroidNotificationSound('coba'),
            playSound: true,
            showWhen: false),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return flutterLocalNotificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  void showPrayerTimeNotification() async {
    // Get the current time
    DateTime currentTime = DateTime.now();

    // Set the prayer time for Subuh (example: 04:00 AM)
    DateTime subuhTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      4, // Hour
      0, // Minute
    );

    // set the prayer time for maghrib (example: 18:00 PM)
    DateTime maghribTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      17, // Hour
      30, // Minute
    );

    // set the prayer time for isya (example: 18:00 PM)
    DateTime isyaTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      18, // Hour
      30, // Minute
    );

    // Calculate the duration until Subuh prayer time
    Duration durationUntilSubuh = subuhTime.difference(currentTime);
    // Calculate the duration until Maghrib prayer time
    Duration durationUntilMaghrib = maghribTime.difference(currentTime);
    // Calculate the duration until Isya prayer time
    Duration durationUntilIsya = isyaTime.difference(currentTime);

    // Check if it's time for Subuh prayer
    if (durationUntilSubuh.inMinutes <= 0) {
      await flutterLocalNotificationsPlugin.show(
          0, // Notification ID
          'Prayer Time',
          'It\'s time for Subuh prayer!', // Notification message
          await notificationDetails());
    } else if (durationUntilMaghrib.inMinutes <= 0) {
      await flutterLocalNotificationsPlugin.show(
          0, // Notification ID
          'Prayer Time',
          'It\'s time for Maghrib prayer!', // Notification message
          await notificationDetails());
    } else if (durationUntilIsya.inMinutes <= 0) {
      await flutterLocalNotificationsPlugin.show(
          0, // Notification ID
          'Prayer Time',
          'It\'s time for Isya prayer!', // Notification message
          await notificationDetails());
    }
  }
}
