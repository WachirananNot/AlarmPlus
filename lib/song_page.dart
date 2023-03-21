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
                        onTap: () async {},
                        child: Card(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                                leading: IconButton(
                                  icon: Icon(!alarmService.songs[index][2]
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                  onPressed: () async {
                                    alarmService.setSelectedSong(index);
                                    alarmService.prevAudio(index);
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
        return Scaffold(
          backgroundColor: alarmService.subColor,
          appBar: AppBar(
            title: const Center(
                child: Text("Songs", style: TextStyle(color: Colors.white))),
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: ListView.builder(
              itemCount: alarmService.songs.length,
              itemBuilder: ((context, index) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: 70,
                    child: GestureDetector(
                        onTap: () async {},
                        child: Card(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                                leading: IconButton(
                                  icon: Icon(!alarmService.songs[index][2]
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                  onPressed: () async {
                                    alarmService.setSelectedSong(index);
                                    alarmService.prevAudio(index);
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
      }
    });
  }
}
