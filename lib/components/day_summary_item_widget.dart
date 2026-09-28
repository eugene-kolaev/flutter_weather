import 'package:flutter/material.dart';
import 'package:flutter_weather/commons/weather_colors.dart';
import 'package:flutter_weather/components/card_widget.dart';
import 'package:flutter_weather/components/condition_image_widget.dart';

class DaySummaryItemWidget extends StatelessWidget {
  final String date;
  final String description;
  final int maxTemp;
  final int minTemp;
  final int code;

  const DaySummaryItemWidget({
    super.key,
    required this.date,
    required this.description,
    required this.maxTemp,
    required this.minTemp,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: WeatherColors.textColorSubtitle,
                  ),
                ),
              ],
            ),
            Expanded(child: Container(height: 50)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$maxTemp°',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  '$minTemp°',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Container(height: 35, width: 1, color: Colors.black),
            const SizedBox(width: 8),
            ConditionImageWidget(weatherCode: code),
          ],
        ),
      ),
    );
  }
}
