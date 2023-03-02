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
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(
      builder: (_, alarmService, __) {
        return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
              title: const Center(
            child: Text('Alarm', style: TextStyle(color: Colors.white)),
          )),
          body: Center(
            child: alarmService.time.isEmpty
                ? const Text("There is no alarm at this time.")
                : const Text("Test"),
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
                              const TimeScrollPicker(),
                              const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
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
                              const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
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
                              const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
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
