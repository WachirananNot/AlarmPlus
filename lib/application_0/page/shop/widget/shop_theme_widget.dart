// -----------------------------------------------------------------------------
// Natchareeya Panya 630510616 (Feature should have: Reward managment, Could have: Shop)
// -----------------------------------------------------------------------------
// shop_theme_widget.dart
// -----------------------------------------------------------------------------
//
// This file contains the implementation of the ThemeShop widget
// which allows users to purchase themes with coins.
// The widget shows a grid of themes, each with an image and a caption showing.
// whether it is owned or available for purchase for 100 coins.
// If a theme is not owned, the user can tap on it to bring up a dialog asking.
// If the user has enough coins, the theme is purchased and saved,
// and the user's coin balance is updated.
// If the user does not have enough coins,
// a dialog appears informing the user that they do not have enough coins to purchase the theme.
// The widget is built using the Provider package to manage state
// and access data from the AlarmService class.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../alarm_service.dart';

// -----------------------------------------------------------------------------
// ThemeShop
// -----------------------------------------------------------------------------
// The ThemeShop class is a stateful widget
// can be used to display a list of theme available for purchase within an app.
class ThemeShop extends StatefulWidget {
  const ThemeShop({super.key});

  @override
  State<ThemeShop> createState() => _ThemeShopState();
}

// -----------------------------------------------------------------------------
// _ThemeShopState
// -----------------------------------------------------------------------------
// A stateful widget class that renders a list of theme.
// The user can tap on a theme and purchase it if they have enough coins.
// If a theme is already purchased, it is displayed as "Owned" and cannot be purchased again.
// If a theme is not purchased, the user is prompted to buy it with a dialog.
// This class manages the theme shop UI and handles the purchase and ownership logic for each theme.
class _ThemeShopState extends State<ThemeShop> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
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
                            title: const Text('Do you want to buy this theme?'),
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
                                                        Navigator.pop(context);
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
    });
  }
}
