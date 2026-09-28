import 'package:flutter/material.dart';
import 'package:flutter_weather/api/weather/dto/hourly_response.dart';
import 'package:flutter_weather/components/condition_image_widget.dart';

class HourlyForecastItemWidget extends StatelessWidget {
  final HourlyResponse hourlyResponse;
  final int index;

  const HourlyForecastItemWidget(
      {super.key, required this.hourlyResponse, required this.index});

  @override
  Widget build(BuildContext context) {
    final times = hourlyResponse.formattedTimes;
    final codes = hourlyResponse.weatherCode ?? const <int>[];
    final temps = hourlyResponse.temperature2m ?? const <double>[];
    final isDayList = hourlyResponse.isDay ?? const <int>[];
    final isNight = index < isDayList.length ? isDayList[index] == 0 : false;

    final time = index < times.length ? times[index] : '--:--';
    final code = index < codes.length ? codes[index] : null;
    final temp = index < temps.length ? temps[index] : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
        const SizedBox(height: 8,),
        ConditionImageWidget(weatherCode: code!, isNight: isNight,),
        const SizedBox(height: 8,),
        Text('${temp!.round()}°',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),)
      ],
    );
  }
}
