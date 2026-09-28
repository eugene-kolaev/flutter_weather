import 'package:flutter/material.dart';
import 'package:flutter_weather/commons/weather_colors.dart';

class ButtonWidget extends StatelessWidget {
  final bool isActive;
  final String text;
  final VoidCallback onTap;

  const ButtonWidget({
    super.key,
    required this.isActive,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          isActive ? WeatherColors.accent : Colors.white,
        ),
        minimumSize: WidgetStateProperty.all<Size>(const Size(90, 42)),
        maximumSize: WidgetStateProperty.all<Size>(const Size(226, 42)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      child: Text(text, style: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}
