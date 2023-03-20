import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alarm_service.dart';

class ThemeList extends StatefulWidget {
  const ThemeList({super.key});

  @override
  State<ThemeList> createState() => _ThemeListState();
}

class _ThemeListState extends State<ThemeList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
            title: const Center(
                child: Text("Theme", style: TextStyle(color: Colors.white))),
          ));
    });
  }
}
