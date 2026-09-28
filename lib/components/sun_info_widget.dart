import 'package:flutter/material.dart';
import 'package:flutter_weather/components/card_widget.dart';
import 'package:flutter_weather/components/icon_widget.dart';

class SunInfoWidget extends StatelessWidget {
  final String type;
  final String time;

  const SunInfoWidget({super.key, required this.type, required this.time});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Row(
        children: [
          IconWidget(
            icon: type == 'Sunrise' ? Icons.wb_twilight : Icons.nights_stay,
          ),
          const SizedBox(width: 10),
          Container(
            height: 42,
            width: 60,
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: TextStyle(fontSize: 14)),
                Text(
                  time,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
