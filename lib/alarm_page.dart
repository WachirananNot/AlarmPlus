import 'package:alarmplus/alarm_service.dart';
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
          body: const Center(
            child: Text("หน้าตั้งปลุกจ้า"),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Increment',
              backgroundColor: alarmService.color,
              child: const Icon(Icons.add, color: Colors.white)),
        );
      },
    );
  }
}
