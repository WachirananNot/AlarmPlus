import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlarmService extends ChangeNotifier {
  late AudioPlayer player = AudioPlayer();
  late MaterialColor color;
  late MaterialColor subColor;
  late Map<int, List<dynamic>> alarmItem = {};
  late int index = 0;
  late int time;
  late int randomNumber;
  late int reward = 100;
  List<String> problems = [
    'asset://assets/problem/1.png',
    'asset://assets/problem/2.png',
    'asset://assets/problem/3.png',
    'asset://assets/problem/4.png',
    'asset://assets/problem/5.png',
    'asset://assets/problem/6.png',
    'asset://assets/problem/7.png',
    'asset://assets/problem/8.png',
    'asset://assets/problem/9.png',
    'asset://assets/problem/10.png',
    'asset://assets/problem/11.png',
    'asset://assets/problem/12.png',
    'asset://assets/problem/13.png',
    'asset://assets/problem/14.png',
    'asset://assets/problem/15.png',
    'asset://assets/problem/16.png',
    'asset://assets/problem/17.png',
    'asset://assets/problem/18.png',
    'asset://assets/problem/19.png',
    'asset://assets/problem/20.png'
  ];
  List<String> ans = [
    "24",
    "18",
    "10",
    "18",
    "55",
    "31",
    "366",
    "12",
    "6",
    "8",
    "40",
    "7",
    "7",
    "8",
    "11",
    "7",
    "5",
    "6",
    "52",
    "4"
  ];
  MaterialColor changeColorCode(int hexColor) {
    color = MaterialColor(hexColor, const <int, Color>{
      50: Color.fromRGBO(238, 129, 48, .1),
      100: Color.fromRGBO(238, 129, 48, .2),
      200: Color.fromRGBO(238, 129, 48, .3),
      300: Color.fromRGBO(238, 129, 48, .4),
      400: Color.fromRGBO(238, 129, 48, .5),
      500: Color.fromRGBO(238, 129, 48, .6),
      600: Color.fromRGBO(238, 129, 48, .7),
      700: Color.fromRGBO(238, 129, 48, .8),
      800: Color.fromRGBO(238, 129, 48, .9),
      900: Color.fromRGBO(238, 129, 48, 1),
    });
    return color;
  }

  Future<void> stopAudio() async {
    int result = await player.stop();

    // You can pasue the player
    // int result = await player.pause();

    if (result == 1) {
      //stop success
      print("Sound playing stopped successfully.");
    } else {
      print("Error on while stopping sound.");
    }
  }

  Future<void> startAudio() async {
    String audioasset = "assets/sound/P.mp3";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
    if (result == 1) {
      //play success
      print("Sound playing successful.");
    } else {
      print("Error while playing sound.");
    }
  }

  void cancelNotification(int index) {
    AwesomeNotifications().cancel(index);
  }

  int getTime() {
    return time;
  }

  void triggerNotification(int index) async {
    time = index;
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();

    int hour = (index ~/ 100);
    int minute = (index % 100);
    String pic = await randomPic();

    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: index,
          channelKey: 'scheduled',
          customSound: "asset://sound/alarm-clock-short-6402.mp3",
          locked: true,
          title: 'Wake Up!',
          body: 'Test',
          wakeUpScreen: true,
          notificationLayout: NotificationLayout.BigPicture,
          fullScreenIntent: true,
          bigPicture: pic,
          autoDismissible: false,
        ),
        schedule: NotificationCalendar(
            hour: hour,
            minute: minute,
            second: 0,
            timeZone: localTimeZone,
            repeats: true),
        actionButtons: [
          NotificationActionButton(
              key: 'Text', label: 'Send answer', requireInputText: true),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              autoDismissible: false,
              actionType: ActionType.DisabledAction,
              isDangerousOption: true),
        ]);
  }

  String getResult() {
    return ans[randomNumber];
  }

  Future<String> randomPic() async {
    randomNumber = Random().nextInt(problems.length);
    String selectedPic = problems[randomNumber];
    return selectedPic;
  }

  void turnOn(int index) {
    alarmItem[index]![1] = true;
  }

  void turnOff(int index) {
    alarmItem[index]![1] = !alarmItem[index]![1];
  }

  void sortListAlarm() {
    if (alarmItem.isNotEmpty && alarmItem.length > 1) {
      List<MapEntry<int, List<dynamic>>> sortedEntries = alarmItem.entries
          .toList()
        ..sort((a, b) => a.value[0].compareTo(b.value[0]));

      Map<int, List<dynamic>> sortedAlarmItem = Map.fromEntries(sortedEntries);
      Map<int, List<dynamic>> updatedAlarmItem = {};

      int newKey = 0;
      sortedAlarmItem.forEach((key, value) {
        updatedAlarmItem[newKey++] = value;
      });
      alarmItem = updatedAlarmItem;
    }
  }

  int? getKey(List<dynamic> alarm) {
    int? result;
    List<MapEntry<int, dynamic>> entries = alarmItem.entries.toList();
    entries.forEach((entry) {
      int key = entry.key;
      dynamic value = entry.value;
      if (value[0].contains(alarm[0])) {
        result = key;
      }
    });
    return result;
  }

  bool checkDup(List<dynamic> alarm) {
    bool isPresent = false;
    List<MapEntry<int, dynamic>> entries = alarmItem.entries.toList();
    entries.forEach((entry) {
      int key = entry.key;
      dynamic value = entry.value;
      if (value[0].contains(alarm[0])) {
        isPresent = true;
      }
    });
    return isPresent;
  }

  void setAlarm(List<dynamic> alarm) {
    bool isPresent = checkDup(alarm);
    if (alarmItem.isEmpty) {
      alarmItem[index] = alarm;
      index += 1;
      sortListAlarm();
    } else if (!isPresent) {
      alarmItem[index] = alarm;
      index += 1;
      sortListAlarm();
    }
  }

  void delAlarm(String time) {
    alarmItem.removeWhere((key, value) => value.contains(time));
    index -= 1;
    sortListAlarm();
  }

  MaterialColor changeSubColorCode(int hexColor) {
    subColor = MaterialColor(hexColor, const <int, Color>{
      50: Color.fromRGBO(238, 129, 48, .1),
      100: Color.fromRGBO(238, 129, 48, .2),
      200: Color.fromRGBO(238, 129, 48, .3),
      300: Color.fromRGBO(238, 129, 48, .4),
      400: Color.fromRGBO(238, 129, 48, .5),
      500: Color.fromRGBO(238, 129, 48, .6),
      600: Color.fromRGBO(238, 129, 48, .7),
      700: Color.fromRGBO(238, 129, 48, .8),
      800: Color.fromRGBO(238, 129, 48, .9),
      900: Color.fromRGBO(238, 129, 48, 1),
    });
    return subColor;
  }
}
