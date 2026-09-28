import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/api/weather/dto/hourly_response.dart';
import 'package:flutter_weather/components/card_title_widget.dart';
import 'package:flutter_weather/components/card_widget.dart';
import 'package:flutter_weather/components/container_widget.dart';
import 'package:flutter_weather/components/line_chart_widget.dart';

class DayForecastWidget extends StatelessWidget {
  final HourlyResponse hourlyResponse;
  final int step;
  final double minHourWidth;
  final bool isTomorrow;
  const DayForecastWidget({super.key, required this.hourlyResponse, this.step = 1, this.minHourWidth = 32, this.isTomorrow = false});

  @override
  Widget build(BuildContext context) {
    final times = hourlyResponse.formattedTimes;
    final temps = hourlyResponse.temperature2m ?? const <double>[];

    final available = [times.length, temps.length]
        .reduce((a, b) => a < b ? a : b);

    if (available == 0) {
      return const SizedBox.shrink();
    }

    return ContainerWidget(
      child: CardWidget(
        child: Column(
          children: [
            CardTitleWidget(
              icon: Icons.calendar_month_outlined,
              title: isTomorrow ? 'Tomorrow' : 'Day forecast',
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final spots = <FlSpot>[];
                final labels = <int, String>{};
                int? currentHourIndex;

                if (isTomorrow) {
                  const fixedStep = 3;
                  const pointsCount = 8;

                  final startIndex = _findTomorrowStartIndex();

                  for (var i = 0; i < pointsCount; i++) {
                    final index = startIndex + i * fixedStep;
                    if (index >= available) break;
                    spots.add(FlSpot(index.toDouble(), temps[index]));
                    labels[index] = times[index];
                  }

                  currentHourIndex = null;
                } else {
                  final pointCount =
                  (constraints.maxWidth / minHourWidth)
                      .floor()
                      .clamp(3, 8);

                  currentHourIndex = _findCurrentHourIndex();

                  final window = _buildWindow(
                    totalAvailable: available,
                    pointCount: pointCount,
                    step: step,
                    currentIndex: currentHourIndex,
                  );

                  for (var i = window.start; i <= window.end; i += step) {
                    spots.add(FlSpot(i.toDouble(), temps[i]));
                    labels[i] = times[i];
                  }
                }

                if (spots.isEmpty) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: LineChartWidget(
                    spots: spots,
                    labels: labels,
                    currentHourIndex: currentHourIndex,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _Window _buildWindow({
    required int totalAvailable,
    required int pointCount,
    required int step,
    required int currentIndex,
  }) {
    final hourSpan = (pointCount - 1) * step;
    final half = hourSpan ~/ 2;

    var start = currentIndex - half;
    var end = start + hourSpan;

    if (start < 0) {
      start = 0;
      end = start + hourSpan;
    }
    if (end > totalAvailable - 1) {
      end = totalAvailable - 1;
      start = end - hourSpan;
      if (start < 0) start = 0;
    }

    return _Window(start: start, end: end);
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

class _Window {
  final int start;
  final int end;
  const _Window({required this.start, required this.end});
}