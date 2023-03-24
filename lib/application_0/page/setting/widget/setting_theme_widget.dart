import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../alarm_service.dart';

class SettingTheme extends StatefulWidget {
  const SettingTheme({super.key});

  @override
  State<SettingTheme> createState() => _SettingThemeState();
}

class _SettingThemeState extends State<SettingTheme> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      BoxDecoration? myBox() {
        if (alarmService.isSelectedTheme) {
          return BoxDecoration(
              border: Border.all(
                  width: 2,
                  color:
                      alarmService.color //                   <--- border width
                  ));
        } else {
          return null;
        }
      }

      return Scaffold(
        backgroundColor: alarmService.subColor,
        appBar: AppBar(
          title: Text("Themes", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: GridView.builder(
            itemCount: alarmService.theme.entries
                .where((entry) => entry.value[3])
                .length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: ((context, index) {
              final filteredList = alarmService.theme.entries
                  .where((entry) => entry.value[3])
                  .toList();
              final currentItem = filteredList[index];
              return Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: GestureDetector(
                  child: alarmService.chosenTheme == index + 1
                      ? Container(
                          decoration: myBox(),
                          child: Image.asset(currentItem.value[0]),
                        )
                      : Image.asset(currentItem.value[0]),
                  onTap: () {
                    setState(() {
                      alarmService.saveChooseTheme(
                          currentItem.value[1], currentItem.value[2]);
                      alarmService.isSelectedTheme = true;
                      alarmService.chosenTheme = index + 1;
                      alarmService.setColor(currentItem.value[1]);
                      alarmService.setSubColor(currentItem.value[2]);
                    });
                  },
                ),
              );
            })),
      );
    });
  }
}
