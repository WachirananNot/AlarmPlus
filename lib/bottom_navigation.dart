import 'package:alarmplus/alarm_page.dart';
import 'package:alarmplus/alarm_service.dart';
import 'package:alarmplus/setting_page.dart';
import 'package:alarmplus/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      return FutureBuilder(
        future: alarmService.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: const [AlarmPage(), ShopPage(), SettingPage()],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.alarm), label: 'Alarm'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Shop'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Setting'),
              ],
            ),
          );
        },
      );
    });
  }
}
