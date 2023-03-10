import 'package:alarmplus/alarm_service.dart';
import 'package:alarmplus/bottom_navigation.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmPlus extends StatefulWidget {
  const AlarmPlus({super.key});

  @override
  State<AlarmPlus> createState() => _AlarmPlusState();
}

class _AlarmPlusState extends State<AlarmPlus> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().cancelAll();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      alarmService.changeSubColorCode(0xffCAC9EE);
      alarmService.changeColorCode(0xff9E9CF3);
      return MaterialApp(
        title: 'Alarm+',
        theme: ThemeData(
          primarySwatch: alarmService.color,
        ),
        home: const BottomNavigation(),
      );
    });
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print(receivedAction.buttonKeyInput);
  }
}

void main() {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          criticalAlerts: true,
          playSound: true,
          soundSource: "",
          channelKey: 'scheduled',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.Max,
        ),
      ],
      debug: true);
  runApp(ChangeNotifierProvider(
    create: (_) => AlarmService(),
    child: const AlarmPlus(),
  ));
}
