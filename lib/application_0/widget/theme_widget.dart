import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../alarm_service.dart';

// -----------------------------------------------------------------------------
// ThemeList
// -----------------------------------------------------------------------------
// The SongList class is a stateful widget.
// It represents a list of themes.
// The State object for this class is _ThemeListState.

class ThemeList extends StatefulWidget {
  const ThemeList({super.key, required this.page});
  final String? page;
  @override
  State<ThemeList> createState() => _ThemeListState();
}

// -----------------------------------------------------------------------------
// _ThemeListState
// -----------------------------------------------------------------------------
//
// _ThemeListState is a stateful widget that defines the UI and functionality for displaying a list of songs.
// It renders different views depending on the page parameter.
// If page is "shop", it displays a list of theme available for purchase,
// otherwise it builds a grid of owned themes that the user can select as their current theme.
// After that, if user want to buy that theme.
// It have to check the reward are enough or not,
// if enough, it will show a dialog to buy the theme.
// If there are not enough reward, a dialog will appear that there are not enough reward.

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
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          if (alarmService.theme[index]![3] == false) {
                            return AlertDialog(
                              title:
                                  const Text('Do you want to buy this theme?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      if (alarmService.reward >= 100) {
                                        alarmService.getTheme(index);
                                        alarmService.saveTheme();
                                        alarmService.saveRewardData();
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                    title: const Text(
                                                        "You don't enough coin"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text('Close'),
                                                      )
                                                    ]));
                                      }
                                    },
                                    child: const Text('OK')),
                              ],
                            );
                          } else {
                            alarmService.saveTheme();
                            return AlertDialog(
                              title: const Text(
                                  'You have already bought this theme.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          }
                        }),
                  ),
                );
              })),
        );
      } else {
        BoxDecoration? myBox() {
          if (alarmService.isSelectedTheme) {
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
      }
    });
  }
}
