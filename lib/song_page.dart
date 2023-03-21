import 'package:alarmplus/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongList extends StatefulWidget {
  const SongList({super.key, this.page});
  final String? page;

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmService>(builder: (_, alarmService, __) {
      if (widget.page == "shop") {
        return Scaffold(
          backgroundColor: alarmService.subColor,
        );
      } else {
        return Scaffold(
            backgroundColor: alarmService.subColor,
            appBar: AppBar(
              title: const Center(
                  child: Text("Songs", style: TextStyle(color: Colors.white))),
            ));
      }
    });
  }
}
