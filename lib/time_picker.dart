import 'package:alarmplus/alarm_service.dart';
import 'package:flutter/material.dart';

class TimeScrollPicker extends StatefulWidget {
  final ValueSetter<int> setHour;
  final ValueSetter<int> setMinute;
  TimeScrollPicker({super.key, required this.setHour, required this.setMinute});

  @override
  State<TimeScrollPicker> createState() => _TimeScrollPickerState();
}

class _TimeScrollPickerState extends State<TimeScrollPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: ListWheelScrollView.useDelegate(
                onSelectedItemChanged: (value) {
                  setState(() {
                    widget.setHour(value);
                  });
                },
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 24,
                  builder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Center(
                        child: Text(
                          index < 10 ? '0$index' : index.toString(),
                          style: const TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 70,
            child: ListWheelScrollView.useDelegate(
                onSelectedItemChanged: (value) {
                  setState(() {
                    widget.setMinute(value);
                  });
                },
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 60,
                  builder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Center(
                        child: Text(
                          index < 10 ? '0$index' : index.toString(),
                          style: const TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
