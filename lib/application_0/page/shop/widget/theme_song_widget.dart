import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../alarm_service.dart';

class ThemeShop extends StatefulWidget {
  const ThemeShop({super.key});

  @override
  State<ThemeShop> createState() => _ThemeShopState();
}

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
