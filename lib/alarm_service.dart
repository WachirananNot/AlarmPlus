import 'package:flutter/material.dart';

class AlarmService extends ChangeNotifier {
  late MaterialColor color;
  late MaterialColor subColor;
  late Map<int, List<dynamic>> alarmItem = {};
  late int index = 0;
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
