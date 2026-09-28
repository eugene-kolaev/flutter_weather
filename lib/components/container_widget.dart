import 'package:flutter/material.dart';
import 'package:flutter_weather/commons/weather_colors.dart';

class ContainerWidget extends StatelessWidget {
  final Widget child;
  final bool short;
  const ContainerWidget({super.key, required this.child,this.short = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: short == false ? const EdgeInsets.symmetric(vertical: 16, horizontal: 24) : const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: child,
    );
  }
}
