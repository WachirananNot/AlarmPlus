import 'package:alarmplus/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongList extends StatefulWidget {
  const SongList({super.key, this.page});
  final String? page;

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      if (widget.page == "shop") {
        return Scaffold(
          backgroundColor: alarmService.subColor,
          body: Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: ListView.builder(
              itemCount: alarmService.songs.length,
              itemBuilder: ((context, index) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: 70,
                    child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                if (!alarmService.songs[index][3]) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Do you want to buy this song?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            if (alarmService.reward >= 100) {
                                              alarmService.getSongs(index);
                                              alarmService.saveRewardData();
                                              Navigator.pop(context);
                                            } else {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                          title: const Text(
                                                              "You don't have enough coin"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Close'),
                                                            )
                                                          ]));
                                            }
                                          },
                                          child: const Text('OK')),
                                    ],
                                  );
                                } else {
                                  return AlertDialog(
                                    title: const Text(
                                        'You have already bought this song.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                }
                              });
                        },
                        child: Card(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: !alarmService.songs[index]![3]
                                        ? const [
                                            Icon(
                                              Icons.attach_money,
                                              color: Colors.yellow,
                                            ),
                                            Text("100",
                                                style: TextStyle(
                                                    color: Colors.yellow))
                                          ]
                                        : [
                                            const Text("Owned",
                                                style: TextStyle(
                                                    color: Colors.green))
                                          ]),
                                leading: IconButton(
                                  icon: Icon(!alarmService.songs[index][2]
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                  onPressed: () async {
                                    alarmService.setPrevSelectedSong(index);
                                    alarmService.prevAudio(index);
                                    alarmService.restoreSong();
                                  },
                                ),
                                title: Text(
                                  alarmService.songs[index][0],
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
      } else {
        alarmService.setPrevSong();
        return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
            title: const Center(
                child: Text("Songs", style: TextStyle(color: Colors.white))),
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
                            alarmService.chosenSong = index + 1;
                            alarmService.selectPrev(index);
                          });
                        },
                        child: Card(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                                trailing: alarmService.chosenSong == index + 1
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
                                  onPressed: () async {
                                    alarmService.selectPrev(index);
                                    alarmService.prevSettingAudio(index);
                                    alarmService.restoreSong();
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
      }
    });
  }
}
