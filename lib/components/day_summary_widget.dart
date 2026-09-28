import 'package:flutter/material.dart';
import 'package:flutter_weather/api/weather/dto/daily_response.dart';
import 'package:flutter_weather/components/card_widget.dart';
import 'package:flutter_weather/components/container_widget.dart';
import 'package:flutter_weather/components/day_summary_item_widget.dart';
import 'package:flutter_weather/components/weather_code_description.dart';

class DaySummaryWidget extends StatelessWidget {
  final DailyResponse dailyResponse;

  const DaySummaryWidget({super.key, required this.dailyResponse});

  @override
  Widget build(BuildContext context) {
    final dates = dailyResponse.formattedDates;
    final code = dailyResponse.weatherCode ?? const <int>[];
    final maxTemp = dailyResponse.temperature2mMax ?? const <double>[];
    final minTemp = dailyResponse.temperature2mMin ?? const <double>[];

    final available = [
      dates.length,
      code.length,
      maxTemp.length,
      minTemp.length,
    ].reduce((a, b) => a < b ? a : b);

    return ContainerWidget(
        child: Column(
          children: [
            for (var i = 0; i < available; i++) ...[
              SizedBox(height: 10,),
              DaySummaryItemWidget(
                date: dates[i],
                description: WeatherCodeDescription.get(code[i]),
                maxTemp: maxTemp[i].toInt(),
                minTemp: minTemp[i].toInt(),
                code: code[i],
              ),
            ]
          ],
        ),
    );
  }
}
