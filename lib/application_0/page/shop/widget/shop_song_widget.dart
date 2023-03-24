import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../alarm_service.dart';
class ShopSong extends StatefulWidget {
  const ShopSong({super.key});

  @override
  State<ShopSong> createState() => _ShopSongState();
}

class _ShopSongState extends State<ShopSong> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
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
                                            alarmService.saveSong();
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
    });
  }
}
