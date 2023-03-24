import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../alarm_service.dart';

class SettingSong extends StatefulWidget {
  const SettingSong({super.key});

  @override
  State<SettingSong> createState() => _SettingSongState();
}

class _SettingSongState extends State<SettingSong> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      alarmService.setPrevSong();
        return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
            title: Text("Songs", style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: ListView.builder(
              itemCount: alarmService.filteredSongs.length,
              itemBuilder: ((context, index) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: 70,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            alarmService.isSelectedSong = true;
                            alarmService.chosenSong =
                                alarmService.filteredSongs[index][4];
                            alarmService.selectPrev(index);
                            alarmService.saveSelectSong();
                            print(alarmService.selectedSong);
                          });
                        },
                        child: Card(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                                trailing: alarmService.chosenSong ==
                                        alarmService.filteredSongs[index][4]
                                    ? const Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        Icons.check_box_outline_blank_outlined,
                                        color: Colors.black,
                                      ),
                                leading: IconButton(
                                  icon: Icon(!alarmService.filteredSongs[index]
                                          [2]
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                  onPressed: () {
                                    alarmService.selectPrev(index);
                                    alarmService.prevSettingAudio(index);
                                    alarmService.restoreSong();
                                    print(alarmService.selectedSong);
                                  },
                                ),
                                title: Text(
                                  alarmService.filteredSongs[index][0],
                                  style: Theme.of(context).textTheme.headline6,
                                )),
                          ],
                        ))),
                  ),
                );
              }),
            ),
          ),
        );
    });
  }
}
