import 'package:flutter/material.dart';
import 'package:flutter_weather/api/weather/dto/daily_response.dart';
import 'package:flutter_weather/components/container_widget.dart';
import 'package:flutter_weather/components/sun_info_widget.dart';

class AstronomyWidget extends StatelessWidget {
  final bool isTomorrow;
  final DailyResponse dailyResponse;

  const AstronomyWidget({
    super.key,
    required this.dailyResponse,
    this.isTomorrow = false,
  });

  @override
  Widget build(BuildContext context) {
    final index = isTomorrow ? 1 : 0;

    final sunriseList = dailyResponse.sunrise ?? const <String>[];
    final sunsetList = dailyResponse.sunset ?? const <String>[];

    final sunrise = index < sunriseList.length ? sunriseList[index] : '--:--';
    final sunset = index < sunsetList.length ? sunsetList[index] : '--:--';

    final sunriseWidget = SunInfoWidget(type: 'Sunrise', time: sunrise);
    final sunsetWidget = SunInfoWidget(type: 'Sunset', time: sunset);

    // return Container(
    //   child: Column(
    //     children: [
    //       SunInfoWidget(
    //         type: 'Sunrise',
    //         time: dailyResponse.sunrise?[index] ?? '--:--',
    //       ),
    //       SizedBox(height: 3,),
    //       SunInfoWidget(
    //         type: 'Sunset',
    //         time: dailyResponse.sunset?[index] ?? '--:--',
    //       ),
    //     ],
    //   ),
    // );
    return ContainerWidget(
      child: isTomorrow
      // Завтра — горизонтально
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: sunriseWidget),
          SizedBox(width: 8,),
          Expanded(child: sunsetWidget),
        ],
      )
      // Сегодня — вертикально
          : Column(
        children: [
          sunriseWidget,
          SizedBox(height: 3,),
          sunsetWidget,
        ],
      ),
    );
  }
}
