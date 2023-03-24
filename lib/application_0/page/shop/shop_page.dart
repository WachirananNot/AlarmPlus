// -----------------------------------------------------------------------------
// Natchareeya Panya 630510616 (Feature should have: Reward managment, Could have: Shop)
// -----------------------------------------------------------------------------
// shop_page.dart
// -----------------------------------------------------------------------------
//
// This file contains the implementation of the ShopPage widget
// which represents the page of a virtual shop within an app.
// It displays different items available for purchase, and the user
// can buy them using in-app currency.
import 'package:alarmplus/alarm_service.dart';
import 'package:alarmplus/application_0/page/shop/widget/shop_song_widget.dart';
import 'package:alarmplus/application_0/page/shop/widget/shop_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
// ShopPage
// -----------------------------------------------------------------------------
// The ShopPage class is a stateful widget
// that represents the page of a virtual shop within an app.
// It displays different items available for purchase,
// and the user can buy them using in-app currency.
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

// -----------------------------------------------------------------------------
// _ShopPageState
// -----------------------------------------------------------------------------
// This is the state class for the ShopPage widget.
// It manages the state of the page and displays the contents of the ShopPage.
// The ShopPage displays two tabs, one for purchasing themes and one for purchasing songs.
// The stateful widget also uses the Consumer widget to listen to changes in the AlarmService,
// which manages the user's coins and purchased items.
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
                        child: const ThemeShop(),
                      ),
                      Container(
                        child: const Center(child: ShopSong()),
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
