import 'package:flutter/material.dart';
import 'package:flutter_weather/api/weather/dto/weather_response.dart';
import 'package:flutter_weather/components/astronomy_widget.dart';
import 'package:flutter_weather/components/container_widget.dart';

class MainTempWidget extends StatelessWidget {
  final int tempC;
  final int feelsLikeTempC;
  final WeatherResponse weatherResponse;

  const MainTempWidget({
    super.key,
    required this.tempC,
    required this.feelsLikeTempC, required this.weatherResponse,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          height: 64,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$tempC°", style: TextStyle(fontSize: 57),),
              // SizedBox(height: 10,),
              Text("Feels like $feelsLikeTempC°", style: TextStyle(fontSize: 16),),
            ],
          )
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: AstronomyWidget(dailyResponse: weatherResponse.daily!),
        ),
      ],

    ));
  }
}
