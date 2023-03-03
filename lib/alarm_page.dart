// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:alarmplus/alarm_service.dart';
import 'package:alarmplus/time_picker.dart';
import 'package:flutter/material.dart';
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

    return Consumer<AlarmService>(
      builder: (_, alarmService, __) {
        return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
              title: const Center(
            child: Text('Alarm', style: TextStyle(color: Colors.white)),
          )),
          body: Center(
            child: alarmService.listTime.isEmpty
                ? const Text("There is no alarm at this time.")
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: alarmService.listTime.length,
                    itemBuilder: (((context, index) {
                      return GestureDetector(
                        child: Card(
                          child: ListTile(
                            title: Text(
                              alarmService.listTime[index],
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_forever),
                              onPressed: () {
                                currentTime = alarmService.listTime[index];
                                setState(() {
                                  alarmService.listTime.remove(currentTime);
                                  currentTime = "";
                                });
                              },
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
                                  Navigator.pop(context);
                                  setState(() {
                                    alarmService.setTime("${hour}:${minute}");
                                    hour = "00";
                                    minute = "00";
                                  });

                                  print(alarmService.listTime);
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
