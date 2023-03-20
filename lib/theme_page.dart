import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alarm_service.dart';

class ThemeList extends StatefulWidget {
  const ThemeList({super.key, required this.page});
  final String? page;
  @override
  State<ThemeList> createState() => _ThemeListState();
}

class _ThemeListState extends State<ThemeList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      if (widget.page == "shop") {
        return Scaffold(
          backgroundColor: alarmService.subColor,
          body: GridView.builder(
              itemCount: alarmService.theme.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: ((context, index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: GestureDetector(
                    child: Image.asset(alarmService.theme[index]![0]),
                    onTap: () {},
                  ),
                );
              })),
        );
      } else {
        return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
            title: const Center(
                child: Text("Themes", style: TextStyle(color: Colors.white))),
          ),
          body: GridView.builder(
              itemCount: alarmService.theme.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: ((context, index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: GestureDetector(
                    child: Image.asset(alarmService.theme[index]![0]),
                    onTap: () {
                      setState(() {
                        alarmService.setColor(alarmService.theme[index]![1]);
                        alarmService.setSubColor(alarmService.theme[index]![2]);
                      });
                    },
                  ),
                );
              })),
        );
      }
    });
  }
}
