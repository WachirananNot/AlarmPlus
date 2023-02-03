import 'package:alarmplus/alarm_service.dart';
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
              title: const Center(
            child: Text('Shop',style: TextStyle(color: Colors.white)),
          )),
          body: const Center(
            child: Text("หน้าร้านค้าจ้า"),
          ),
        );
      },
    );
  }
}