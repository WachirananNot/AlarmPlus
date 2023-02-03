import 'package:alarmplus/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(
      builder: (_, alarmService, __) {
        return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
              title: const Center(
            child: Text('Setting', style: TextStyle(color: Colors.white)),
          )),
          body: const Center(
            child: Text("หน้าตั้งค่าจ้า"),
          ),
        );
      },
    );
    ;
  }
}
