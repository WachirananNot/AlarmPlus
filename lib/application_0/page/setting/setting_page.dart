// -----------------------------------------------------------------------------
// Wachiranan Phuangpanya 630510642 (Feature should have: Setting theme and sound)
// -----------------------------------------------------------------------------
// setting_page.dart
// -----------------------------------------------------------------------------
// This is a Flutter widget that represents a settings page in an alarm application. 
// The page includes a list of settings options, such as changing the alarm tone or theme. 
// The widget imports the necessary packages and uses the Provider package to consume data from the AlarmService.

import 'package:alarmplus/alarm_service.dart';
import 'package:alarmplus/application_0/page/setting/widget/setting_song_widget.dart';
import 'package:alarmplus/application_0/page/setting/widget/setting_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
// SettingPage
// -----------------------------------------------------------------------------
//
// This class represents a setting page widget that allows users to navigate 
// between different settings options such as changing songs or changing themes.
// It extends the StatefulWidget class and defines a State object that manages the widget's state.
// The class includes a list of menu options and corresponding pages that are displayed when each option is selected.
// The class also uses the Consumer widget to listen for changes in the AlarmService state and update the widget accordingly.
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> menu = ["Change Song", "Change Theme"];
  List<Widget> pages = [
    const SettingSong(),
    const SettingTheme()
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
