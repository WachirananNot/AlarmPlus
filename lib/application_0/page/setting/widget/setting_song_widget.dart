// -----------------------------------------------------------------------------
// Wachiranan Phuangpanya 630510642 (Feature should have: Setting theme and sound)
// -----------------------------------------------------------------------------
// setting_song_widget.dart
// -----------------------------------------------------------------------------
// This is a Flutter widget that displays a list of songs that the user can select as an alarm tone. 
// It is connected to a Provider-based AlarmService object, which handles the business logic of selecting and playing songs. 
// a checkbox indicating if the song is currently selected, and a play/pause button that starts and stops playback of the song. 
// When a song is selected, the AlarmService object is updated and the selection is saved. 

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../alarm_service.dart';

// -----------------------------------------------------------------------------
// SettingSong
// -----------------------------------------------------------------------------
//
// This is a Flutter StatefulWidget class called SettingSong that provides a UI for selecting and playing alarm sounds. 
// The class uses the Provider package to access an instance of an AlarmService class 
// that manages the available alarm sounds and the user's chosen sound.
// The SettingSong class displays a list of available alarm sounds as Cards with each sound's name, play/pause button, and checkbox. 
// The checkbox is used to indicate the user's chosen sound. When the user taps on a sound, the class updates the state to reflect the user's choice 
// and saves the selected sound using the AlarmService class. The play/pause button allows the user to preview each sound before selecting it.
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
