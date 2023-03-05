// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:alarmplus/alarm_service.dart';
import 'package:alarmplus/onpress_alarm.dart';
import 'package:alarmplus/time_picker.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  String hour = "00";
  String minute = "00";
  String currentTime = "";
  @override
  Widget build(BuildContext context) {
    void onHourChange(int value) {
      hour = value < 10 ? '0$value' : value.toString();
    }

    void onMinuteChange(int value) {
      minute = value < 10 ? '0$value' : value.toString();
    }

    void pressEdit() {
      setState(() {});
    }

    void triggerNotification(int index) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: index,
              channelKey: 'basic_channel',
              title: 'Test Notification of $index',
              body: 'Test'));
    }

    return Consumer<AlarmService>(
      builder: (_, alarmService, __) {
        return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
              title: const Center(
            child: Text('Alarm', style: TextStyle(color: Colors.white)),
          )),
          body: Center(
            child: alarmService.alarmItem.isEmpty
                ? const Text("There is no alarm at this time.")
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: alarmService.alarmItem.length,
                    itemBuilder: (((context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            currentTime = alarmService.alarmItem[index]![0];
                            setState(() {
                              alarmService.delAlarm(currentTime);
                              currentTime = "";
                            });
                          });
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AlarmPress(
                                          oldTime:
                                              alarmService.alarmItem[index]![0],
                                          pressEdit: pressEdit,
                                        )));
                            setState(() {});
                          },
                          child: Container(
                            height: 100,
                            child: Card(
                              child: Center(
                                child: ListTile(
                                    title: Text(
                                      alarmService.alarmItem[index]?[0],
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    trailing: LiteRollingSwitch(
                                      value: alarmService.alarmItem[index]![1],
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      width: 100,
                                      textOn: "On",
                                      textOff: "Off",
                                      colorOn: Colors.greenAccent,
                                      colorOff: Colors.redAccent,
                                      iconOn: Icons.done,
                                      iconOff: Icons.alarm_off,
                                      onChanged: (bool position) {},
                                      onTap: () {
                                        alarmService.turnOff(index);
                                      },
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                    )),
                              ),
                            ),
                          ),
                        ),
                      );
                    }))),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: alarmService.subColor,
                          title: const Text("Add Alarm"),
                          content: SingleChildScrollView(
                            child: Column(children: [
                              TimeScrollPicker(
                                setHour: onHourChange,
                                setMinute: onMinuteChange,
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.edit),
                                      Text("Name"),
                                    ],
                                  ),
                                  const Text("First Alarm")
                                ],
                              )
                            ]),
                          ),
                          actions: [
                            TextButton(
                                onPressed: (() {
                                  Navigator.pop(context);
                                }),
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: (() {
                                  triggerNotification(int.parse(hour + minute));
                                  Navigator.pop(context);
                                  alarmService.setAlarm([
                                    "${hour}:${minute}",
                                    true,
                                    int.parse(hour + minute)
                                  ]);
                                  setState(() {
                                    hour = "00";
                                    minute = "00";
                                  });
                                  print(alarmService.alarmItem);
                                }),
                                child: const Text("Confirm")),
                          ],
                        ));
              },
              tooltip: 'Increment',
              backgroundColor: alarmService.color,
              child: const Icon(Icons.add, color: Colors.white)),
        );
      },
    );
  }
}
