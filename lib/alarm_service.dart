import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmService extends ChangeNotifier {
  late AudioPlayer player = AudioPlayer();
  late MaterialColor color = changeColorCode(0xff9E9CF3);
  late MaterialColor subColor = changeSubColorCode(0xffCAC9EE);
  late Map<int, List<dynamic>> alarmItem = {};
  late int index = 0;
  late int time;
  late int randomNumber;
  late int reward = 100;
  late int currentReward = 30;
  late int chosenTheme = 1;
  late int chosenSong = 0;
  late bool isSelectedTheme = false;
  late bool isSelectedSong = false;
  late bool isCorrect = false;
  late bool isPlaying = false;
  late String selectedSong = "assets/sound/Default.mp3";
  late String oldSong = "";
  late String prevSong = "";
  late int oldIndexSong = 0;
  late List<dynamic> filteredSongs;
  Map<int, List<dynamic>> theme = {
    0: ["assets/theme/blue.png", 0xff5DBAFE, 0xffC1E1F9, false],
    1: ["assets/theme/green.png", 0xff35934F, 0xff83DA9B, false],
    2: ["assets/theme/purple.png", 0xff9E9CF3, 0xffCAC9EE, true],
    3: ["assets/theme/red.png", 0xffFF8181, 0xffFFB4B4, false]
  };
  List<dynamic> songs = [
    ["Default", "assets/sound/Default.mp3", true, true, 0],
    ["After Like", "assets/sound/A.mp3", true, false, 1],
    ["Big Enough", "assets/sound/B.mp3", true, false, 2],
    ["Bang-Ra-Jan", "assets/sound/Bang-Ra-Jan.mp3", true, false, 3],
    ["Cupid", "assets/sound/C.mp3", true, false, 4],
    ["JoJo", "assets/sound/JoJo.mp3", true, false, 5],
    [
      "Never Gonna Give You Up",
      "assets/sound/Never Gonna Give You Up.mp3",
      true,
      false,
      6
    ],
    ["OMG", "assets/sound/O.mp3", true, false, 7],
    ["U R MINE", "assets/sound/P.mp3", true, false, 8],
    ["Samsung", "assets/sound/Samsung.mp3", true, false, 9],
  ];

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

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    // final getChoseSong = prefs.getInt("ChoseSong");
    // chosenSong = getChoseSong ?? 1;

    final getMoney = prefs.getInt("money");
    reward = getMoney ?? 100;
    // reward = 10000;

    final getThemeDetail = prefs.getStringList("themes");
    if (getThemeDetail != null) {
      int i = 0;
      getThemeDetail.forEach((element) {
        if (element == 'true') {
          theme[i]![3] = true;
        } else {
          theme[i]![3] = false;
        }
        i += 1;
      });
    }

    final getSongDetail = prefs.getStringList("songs");
    if (getSongDetail != null) {
      int i = 0;
      for (var element in getSongDetail) {
        if (element == 'true') {
          songs[i]![3] = true;
        } else {
          songs[i]![3] = false;
        }
        i += 1;
      }
    }

    final getIndexSong = prefs.getInt("songIndex");
    chosenSong = getIndexSong ?? 0;

    final getLinkSong = prefs.getString("songLink");
    selectedSong = getLinkSong ?? "assets/sound/Default.mp3";

    // final getColorCode = prefs.getInt("colorCode");
    // if (getColorCode != null) {
    //   color = changeColorCode(getColorCode);
    // }

    // final getSubColorCode = prefs.getInt("subColorCode");
    // if (getSubColorCode != null) {
    //   subColor = changeColorCode(getSubColorCode);
    // }
  }

  Future<void> saveRewardData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt("money", reward);
  }

  Future<void> saveChooseTheme(int colorCode, int subColorCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("colorCode", colorCode);
    await prefs.setInt("subColorCode", subColorCode);
  }

  Future<void> saveSelectSong() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("songIndex", chosenSong);
    await prefs.setString("songLink", selectedSong);
  }

  Future<void> saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = [];

    theme.forEach((key, value) {
      if (theme[key]![3] == true) {
        data.add('true');
      } else {
        data.add('false');
      }
    });
    // data = ['false', 'false', 'true', 'false'];
    prefs.setStringList('themes', data);
  }

  Future<void> saveSong() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = [];
    songs.forEach(
      (element) {
        if (element[3] == true) {
          data.add('true');
        } else {
          data.add('false');
        }
      },
    );
    // data = [
    //   'true',
    //   'false',
    //   'false',
    //   'false',
    //   'false',
    //   'false',
    //   'false',
    // ];
    prefs.setStringList('songs', data);
  }

  void setPrevSong() {
    filteredSongs = songs.where((song) => song[3] == true).toList();
  }

  void selectPrev(int index) {
    oldSong = selectedSong;
    selectedSong = filteredSongs[index][1];
  }

  void restoreSong() {
    selectedSong = oldSong;
  }

  void setPrevSelectedSong(int index) {
    oldSong = selectedSong;
    selectedSong = songs[index][1];
    notifyListeners();
  }

  void setColor(int hexColor) {
    color = changeColorCode(hexColor);
    notifyListeners();
  }

  void setSubColor(int hexColor) {
    subColor = changeSubColorCode(hexColor);
    notifyListeners();
  }

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

  void getTheme(int index) async {
    theme[index]![3] = true;
    reward = reward - 100;
    await saveRewardData();
    notifyListeners();
  }

  void getSongs(int index) {
    songs[index][3] = true;
    reward = reward - 100;
    notifyListeners();
  }

  Future<void> updateReward() async {
    reward += currentReward;
    currentReward = 30;
    isCorrect = true;
    notifyListeners();
  }

  void decreaseReward() {
    if (currentReward - 10 >= 0) {
      currentReward = currentReward - 10;
    } else {
      currentReward = 0;
    }
    notifyListeners();
  }

  Future<void> prevSettingAudio(int index) async {
    if (filteredSongs[index][2]) {
      if (oldIndexSong != index) {
        if (oldIndexSong != -1) {
          filteredSongs[oldIndexSong][2] = true;
          stopAudio();
        }
        oldIndexSong = index;
      }
      startAudio();
      filteredSongs[index][2] = false;
    } else {
      if (oldIndexSong == index) {
        oldIndexSong = -1;
      }
      stopAudio();
      filteredSongs[index][2] = true;
    }

    notifyListeners();
  }

  Future<void> prevAudio(int index) async {
    if (songs[index][2]) {
      if (oldIndexSong != index) {
        if (oldIndexSong != -1) {
          songs[oldIndexSong][2] = !songs[oldIndexSong][2];
          stopAudio();
        }
        oldIndexSong = index;
      }
      startAudio();
      songs[index][2] = !songs[index][2];
    } else {
      if (oldIndexSong == index) {
        oldIndexSong = -1;
      }
      stopAudio();
      songs[index][2] = !songs[index][2];
    }

    notifyListeners();
  }

  Future<void> stopAudio() async {
    int result = await player.stop();
    isPlaying = false;
    notifyListeners();
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
    player.setReleaseMode(ReleaseMode.LOOP);
    String audioasset = selectedSong;
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
    player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.PLAYING;
    });
    notifyListeners();
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

  void triggerNotification(int index, String name) async {
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
          title: name,
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
    notifyListeners();
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
