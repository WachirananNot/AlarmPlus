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
                  crossAxisCount: 3, childAspectRatio: 0.7),
              itemBuilder: ((context, index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: GestureDetector(
                    child: Column(
                      children: [
                        Image.asset(alarmService.theme[index]![0]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: !alarmService.theme[index]![3]
                                ? const [
                                    Icon(
                                      Icons.attach_money,
                                      color: Colors.yellow,
                                    ),
                                    Text("100",
                                        style: TextStyle(color: Colors.yellow))
                                  ]
                                : [
                                    const Text("Owned",
                                        style: TextStyle(color: Colors.white))
                                  ])
                      ],
                    ),
                    onTap: () {
                      //ตอนกดแล้วซื้อทำตรงนี้
                    },
                  ),
                );
              })),
        );
      } else {
        BoxDecoration? myBox() {
          if (alarmService.isSelected) {
            return BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: alarmService
                        .color //                   <--- border width
                    ));
          } else {
            return null;
          }
        }

        return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
            title: const Center(
                child: Text("Themes", style: TextStyle(color: Colors.white))),
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
                    child: alarmService.chosen == index + 1
                        ? Container(
                            decoration: myBox(),
                            child: Image.asset(currentItem.value[0]),
                          )
                        : Image.asset(currentItem.value[0]),
                    onTap: () {
                      setState(() {
                        alarmService.isSelected = true;
                        alarmService.chosen = index + 1;
                        alarmService.setColor(currentItem.value[1]);
                        alarmService.setSubColor(currentItem.value[2]);
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
