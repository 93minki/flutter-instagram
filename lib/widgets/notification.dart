import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

initNotification(context) async {
  var androidSetting = const AndroidInitializationSettings('app_icon');

  var iosSetting = const IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings = InitializationSettings(
    android: androidSetting,
    iOS: iosSetting,
  );

  await notifications.initialize(initializationSettings,
      onSelectNotification: (payload) {
    // 알림 눌렀을 때 원하는 페이지 띄울 수 있음
    // payload가 플러터에서 좀 오류가 있어서 잘 안쓰인다네??
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Text("New Page"),
      ),
    );
  });
}

showNotification() async {
  var androidDetails = const AndroidNotificationDetails(
    '유니크한 알림 채널 ID',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = const IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  notifications.show(
    1,
    '제목1',
    '내용1',
    NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    ),
  );
}

showNotification2() async {
  tz.initializeTimeZones();

  var androidDetails = const AndroidNotificationDetails(
    '유니크한 알림 ID',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );
  var iosDetails = const IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  notifications.zonedSchedule(
    2,
    '제목2',
    '내용2',
    tz.TZDateTime.now(tz.local).add(
      Duration(seconds: 5),
    ),
    NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}
