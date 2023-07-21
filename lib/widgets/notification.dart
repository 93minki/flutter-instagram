import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

initNotification(context) async {
  var androidSetting = const AndroidInitializationSettings('app_icon');

  var iosSetting = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings = InitializationSettings(
    android: androidSetting,
    iOS: iosSetting,
  );

  await notifications.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
    // 알림 눌렀을 때 원하는 페이지 띄울 수 있음
    // payload가 플러터에서 좀 오류가 있어서 잘 안쓰인다네??
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Text("New Page"),
      ),
    );
  });
}

showNotification() async {
  print("show notification");
  var androidDetails = const AndroidNotificationDetails(
    '유니크한 알림 채널 ID',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(1225, '제목1', '내용1',
      NotificationDetails(android: androidDetails, iOS: iosDetails));
  print("end");
}

showNotification2() async {
  tz.initializeTimeZones();

  var androidDetails = const AndroidNotificationDetails(
    '23',
    '3sec',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  notifications.zonedSchedule(
    33,
    '3초뒤에 오는 알람',
    '내용은 그냥 아무거나',
    tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

showNotification3() async {
  tz.initializeTimeZones();

  var androidDetails = const AndroidNotificationDetails(
    '유니크한 알림 ID',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );
  var iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  notifications.zonedSchedule(
    // show가 아님.
    2,
    '제목2',
    '내용2',
    makeDate(8, 30, 0), // 매일 8시 30분마다 반복
    NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  // 주기적으로 알림 띄우기
  // notifications.periodicallyShow(
  //   2,
  //   '제목2',
  //   '내용2',
  //   RepeatInterval.daily, // 일일 로그인 보상?
  //   NotificationDetails(android: androidDetails, iOS: iosDetails),
  //   androidAllowWhileIdle: true,
  // );

  // 매일 7시에 알람을 띄우고 싶으면
  // notifications.zonedSchedule(
  //   // show가 아님.
  //   2,
  //   '제목2',
  //   '내용2',
  //   tz.TZDateTime.now(tz.local).add(
  //     //tz.TZDateTime.now(tz.local) 은 기기의 현재 시각임. (날짜, 시간)
  //     const Duration(seconds: 2),
  //   ),
  //   NotificationDetails(
  //     android: androidDetails,
  //     iOS: iosDetails,
  //   ),
  //   androidAllowWhileIdle: true,
  //   uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime,
  //   matchDateTimeComponents: DateTimeComponents.time, // 매일 7시마다.
  // );
}

makeDate(hour, min, sec) {
  var now = tz.TZDateTime.now(tz.local);
  var when =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min, sec);
  if (when.isBefore(now)) {
    return when.add(
      const Duration(
        days: 1,
      ),
    );
  } else {
    return when;
  }
}
