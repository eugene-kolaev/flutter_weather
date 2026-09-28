import 'package:flutter/material.dart';
import 'package:flutter_weather/api/weather/dto/hourly_response.dart';
import 'package:flutter_weather/components/card_title_widget.dart';
import 'package:flutter_weather/components/card_widget.dart';
import 'package:flutter_weather/components/change_of_rain_item_widget.dart';
import 'package:flutter_weather/components/container_widget.dart';

class ChangeOfRainWidget extends StatelessWidget {
  final HourlyResponse hourlyResponse;
  final int hoursToShow;
  final bool isTomorrow;
  final int tomorrowStep;
  final int tomorrowPointsCount;

  const ChangeOfRainWidget({super.key, required this.hourlyResponse, this.hoursToShow = 6, this.isTomorrow = false, this.tomorrowStep = 3, this.tomorrowPointsCount = 9});

  @override
  Widget build(BuildContext context) {
    final times = hourlyResponse.formattedTimes;
    final chance = hourlyResponse.precipitationProbability ?? const <int>[];

    final available = [times.length, chance.length]
        .reduce((a, b) => a < b ? a : b);

    if (available == 0) return const SizedBox.shrink();

    final indices = <int>[];
    final labels = <String>[];
    final values = <int>[];

    if (isTomorrow) {
      final startIndex = _findTomorrowStartIndex();

      for (var i = 0; i < tomorrowPointsCount; i++) {
        final index = startIndex + i * tomorrowStep;
        if (index >= available) break;
        indices.add(index);
        labels.add(times[index]);
        values.add(chance[index]);
      }
    } else {
      final currentIndex = _findCurrentHourIndex();
      final count = (available - currentIndex).clamp(0, hoursToShow);

      for (var i = 0; i < count; i++) {
        indices.add(currentIndex + i);
        labels.add(times[currentIndex + i]);
        values.add(chance[currentIndex + i]);
      }
    }

    if (indices.isEmpty) return const SizedBox.shrink();


    return ContainerWidget(
      child: CardWidget(
        child: Column(
          children: [
            CardTitleWidget(
              icon: Icons.water_drop_outlined,
              title: isTomorrow ? 'Chance of rain (tomorrow)' : 'Chance of rain',
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                for (var i = 0; i < indices.length; i++)
                  ChangeOfRainItemWidget(
                    title: labels[i],
                    chance: values[i],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _findCurrentHourIndex() {
    final raw = hourlyResponse.time;
    if (raw == null || raw.isEmpty) return 0;

    final now = DateTime.now();

    for (var i = 0; i < raw.length; i++) {
      final dt = DateTime.tryParse(raw[i]);
      if (dt == null) continue;
      if (dt.year == now.year &&
          dt.month == now.month &&
          dt.day == now.day &&
          dt.hour == now.hour) {
        return i;
      }
    }

    for (var i = 0; i < raw.length; i++) {
      final dt = DateTime.tryParse(raw[i]);
      if (dt == null) continue;
      if (!dt.isBefore(now)) return i;
    }

    return 0;
  }

  int _findTomorrowStartIndex() {
    final raw = hourlyResponse.time;
    if (raw == null || raw.isEmpty) return 0;

    final tomorrow = DateTime.now().add(const Duration(days: 1));

    for (var i = 0; i < raw.length; i++) {
      final dt = DateTime.tryParse(raw[i]);
      if (dt == null) continue;
      if (dt.year == tomorrow.year &&
          dt.month == tomorrow.month &&
          dt.day == tomorrow.day &&
          dt.hour == 0) {
        return i;
      }
    }

    return 24;
  }
}
