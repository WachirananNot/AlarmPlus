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
  late NotificationController notificationController;
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    notificationController = NotificationController(
        Provider.of<AlarmService>(context, listen: false));
    AwesomeNotifications().cancelAll();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: ((receivedAction) =>
            NotificationController.onActionReceivedMethod(
                receivedAction, notificationController)),
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod: ((receivedNotification) =>
            NotificationController.onNotificationDisplayedMethod(
                receivedNotification, notificationController)),
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
  late final AlarmService alarmService;
  NotificationController(this.alarmService);

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification,
      NotificationController notificationController) async {
    print("Notification is showned up and play sound");
    await notificationController.alarmService.startAudio();
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // AwesomeNotifications().dismiss();
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction,
      NotificationController notificationController) async {
    print(receivedAction);
    Map<int, List<dynamic>> alarmItem =
        notificationController.alarmService.alarmItem;
    print(alarmItem);
    if (receivedAction.buttonKeyInput.length != 0) {
      if (notificationController.alarmService.getResult() ==
          receivedAction.buttonKeyInput) {
        AwesomeNotifications().dismissAllNotifications();
        print("Equal");
        await notificationController.alarmService.stopAudio();
        notificationController.alarmService.updateReward();
        print(notificationController.alarmService.reward);
      } else {
        notificationController.alarmService.decreaseReward();
        print(notificationController.alarmService.currentReward);
      }
    }
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
