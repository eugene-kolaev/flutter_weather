import 'package:flutter/material.dart';
import 'package:flutter_weather/commons/weather_colors.dart';

class ChangeOfRainItemWidget extends StatelessWidget {
  final String title;
  final int chance;

  const ChangeOfRainItemWidget({
    super.key,
    required this.title,
    required this.chance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 45,
          alignment: Alignment.centerRight,
          child: Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 24,
                decoration: const BoxDecoration(
                  color: WeatherColors.chartSecond,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
              ),
              FractionallySizedBox(
                widthFactor: chance.toDouble() / 100.0,
                child: Container(
                  height: 24,
                  decoration: const BoxDecoration(
                    color: WeatherColors.chartAccent,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Container(
          width: 45,
          child: Text(
            '$chance%',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    ),
    );
  }
}
