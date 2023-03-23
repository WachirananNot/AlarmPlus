import 'package:alarmplus/alarm_service.dart';
import 'package:alarmplus/shop_page.dart';
import 'package:alarmplus/song_page.dart';
import 'package:alarmplus/theme_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> menu = ["Change Song", "Change Theme"];
  List<Widget> pages = [
    const SongList(
      page: "",
    ),
    const ThemeList(
      page: "",
    )
  ];
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
            body: Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: ListView.builder(
                itemCount: menu.length,
                itemBuilder: ((context, index) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: 100,
                      child: GestureDetector(
                          onTap: () {
          
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => pages[index]));
                          },
                          child: Card(
                              child: Center(
                                  child: ListTile(
                                      title: Text(
                            menu[index],
                            style: Theme.of(context).textTheme.headline5,
                          ))))),
                    ),
                  );
                }),
              ),
            ));
      },
    );
  }
}
// Container(
//                 margin: EdgeInsets.only(top: 50),
//                 child: Wrap(
//                   spacing: 10,
//                   children: [
//                     ElevatedButton.icon(
//                         onPressed: () async {
//                           String audioasset = "assets/sound/P.mp3";
//                           ByteData bytes = await rootBundle
//                               .load(audioasset); //load sound from assets
//                           Uint8List soundbytes = bytes.buffer.asUint8List(
//                               bytes.offsetInBytes, bytes.lengthInBytes);
//                           int result = await player.playBytes(soundbytes);
//                           if (result == 1) {
//                             //play success
//                             print("Sound playing successful.");
//                           } else {
//                             print("Error while playing sound.");
//                           }
//                         },
//                         icon: Icon(Icons.play_arrow),
//                         label: Text("Play")),
//                     ElevatedButton.icon(
//                         onPressed: () async {
//                           int result = await player.stop();

//                           // You can pasue the player
//                           // int result = await player.pause();

//                           if (result == 1) {
//                             //stop success
//                             print("Sound playing stopped successfully.");
//                           } else {
//                             print("Error on while stopping sound.");
//                           }
//                         },
//                         icon: Icon(Icons.stop),
//                         label: Text("Stop")),
//                   ],
//                 ))