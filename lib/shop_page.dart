import 'package:alarmplus/alarm_service.dart';
import 'package:alarmplus/song_page.dart';
import 'package:alarmplus/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(
      builder: (_, alarmService, __) {
        return Scaffold(
            backgroundColor: alarmService.subColor,
            appBar: AppBar(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shop', style: TextStyle(color: Colors.white)),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: Colors.yellow,
                    ),
                    Text(alarmService.reward.toString(),
                        style: TextStyle(color: Colors.yellow))
                  ],
                )
              ],
            )),
            body: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      tabs: [Tab(text: "Themes"), Tab(text: "Songs")],
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: TabBarView(children: <Widget>[
                      Container(
                        child: ThemeList(
                          page: "shop",
                        ),
                      ),
                      Container(
                        child: Center(
                            child: SongList(
                          page: "shop",
                        )),
                      ),
                    ]),
                  )
                ],
              ),
            ));
      },
    );
  }
}
