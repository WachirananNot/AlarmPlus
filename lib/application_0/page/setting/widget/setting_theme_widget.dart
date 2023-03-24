// -----------------------------------------------------------------------------
// Wachiranan Phuangpanya 630510642 (Feature should have: Setting theme and sound)
// -----------------------------------------------------------------------------
// setting_theme_widget.dart
// -----------------------------------------------------------------------------
// This is a Flutter widget that represents a screen for selecting a theme for an alarm app. 
// The screen is implemented as a stateful widget that uses the Provider package to retrieve the alarm service instance. 
// The selected theme is displayed in a grid of images, and a border is added to the selected image. 
// When an image is tapped, the corresponding theme is saved and its colors are applied to the app. 

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../alarm_service.dart';
// -----------------------------------------------------------------------------
// SettingTheme
// -----------------------------------------------------------------------------
//
// A StatefulWidget class that represents the Theme Setting Page in the Alarm Plus application.
// It displays a grid of available themes and allows the user to select and apply one of them.
// The class listens to changes in the AlarmService for the selected theme and updates the UI accordingly.
// The class uses the Consumer widget to access the AlarmService and rebuilds the UI whenever there are changes.
class SettingTheme extends StatefulWidget {
  const SettingTheme({super.key});

  @override
  State<SettingTheme> createState() => _SettingThemeState();
}

class _SettingThemeState extends State<SettingTheme> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      
      //myBox()
      //
      //This function returns a BoxDecoration object with a 2-pixel wide border of the color specified 
      // in the alarmService object if the isSelectedTheme property is true, or null otherwise. 
      // The alarmService.color property is used as the color of the border.
      
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
