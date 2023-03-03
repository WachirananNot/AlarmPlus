// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:alarmplus/alarm_service.dart';
import 'package:alarmplus/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmPress extends StatefulWidget {
  final String oldTime;
  const AlarmPress({super.key, required this.oldTime});

  @override
  State<AlarmPress> createState() => _AlarmPressState();
}

class _AlarmPressState extends State<AlarmPress> {
  String hour = "00";
  String minute = "00";
  void onHourChange(int value) {
    hour = value < 10 ? '0$value' : value.toString();
  }

  void onMinuteChange(int value) {
    minute = value < 10 ? '0$value' : value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      return Scaffold(
        appBar: AppBar(
          title:
              const Text("Edit Alarm", style: TextStyle(color: Colors.white)),
        ),
        body: Column(
          children: [
            TimeScrollPicker(setHour: onHourChange, setMinute: onMinuteChange),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.music_note),
                    Text("Sound"),
                  ],
                ),
                const Text("Default")
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.gamepad),
                    Text("Mini-Games"),
                  ],
                ),
                const Text("Random")
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.edit),
                    Text("Name"),
                  ],
                ),
                const Text("First Alarm")
              ],
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () {
                          if (!alarmService.listTime
                              .contains("${hour}:${minute}")) {
                            alarmService.listTime[alarmService.listTime
                                .indexOf(widget.oldTime)] = "${hour}:${minute}";
                          }

                          Navigator.pop(context);
                        },
                        child: const Text('Save'))))
          ],
        ),
      );
    });
  }
}
