import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);
    await _notifications.initialize(initSettings);
  }

  Future<void> scheduleNotification(int id, String title, DateTime date) async {
    final scheduledDate = tz.TZDateTime.from(date, tz.local);
    final dayBefore = scheduledDate.subtract(const Duration(days: 1));

    final dayBeforeScheduled = tz.TZDateTime(
      tz.local,
      dayBefore.year,
      dayBefore.month,
      dayBefore.day,
      10,
      0,
    );

    if (dayBeforeScheduled.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        id,
        'Yarın Önemli Bir Gün! ❤️',
        '$title için hazırlıklar tamam mı?',
        dayBeforeScheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails('matchmate_channel', 'Reminders', importance: Importance.max),
          iOS: DarwinNotificationDetails(),
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }

    final sameDayScheduled = tz.TZDateTime(
      tz.local,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      8,
      30,
    );

    if (sameDayScheduled.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        id + 1,
        'Bugün O Gün! 🎉',
        '$title günü geldi çattı. Partnerini mutlu etmeyi unutma!',
        sameDayScheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails('matchmate_channel', 'Reminders', importance: Importance.max),
          iOS: DarwinNotificationDetails(),
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }
}