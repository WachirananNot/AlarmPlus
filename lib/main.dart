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

void main() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests')
  ],debug: true);
  runApp(ChangeNotifierProvider(
    create: (_) => AlarmService(),
    child: const AlarmPlus(),
  ));
}
