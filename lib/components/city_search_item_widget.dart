import 'package:flutter/material.dart';
import 'package:flutter_weather/api/dadata/city_response.dart';
import 'package:flutter_weather/components/card_widget.dart';
import 'package:flutter_weather/components/container_widget.dart';

class CitySearchItemWidget extends StatelessWidget {
  final CityResponse cityResponse;
  final Function(CityResponse cityResponse) onTap;

  const CitySearchItemWidget({
    super.key,
    required this.cityResponse,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(cityResponse);
      },
      child: ContainerWidget(
        short: true,
        child: CardWidget(
            child: Padding(
                padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cityResponse.city, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
                Text(cityResponse.regionWithType, style: TextStyle(fontSize: 12, color: Colors.black54),),
              ],
            ),),
        ),
      ),
    );
  }
}
