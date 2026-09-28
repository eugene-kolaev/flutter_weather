import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/commons/weather_colors.dart';

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> spots;
  final Map<int, String>? labels;
  final int? currentHourIndex;
  final double height;

  const LineChartWidget({
    super.key,
    required this.spots,
    this.labels,
    this.currentHourIndex,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (spots.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('No data')),
      );
    }

    final minX = spots.first.x;
    final maxX = spots.last.x;
    final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 2;
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 2;

    const leftAxisWidth = 32.0;
    const bottomAxisHeight = 24.0;

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final chartWidth = constraints.maxWidth - leftAxisWidth;
          final chartHeight = height - bottomAxisHeight;

          final currentSpot = currentHourIndex != null
              ? _resolveCurrentSpot(spots, currentHourIndex!)
              : null;

          double? markerX;
          double? markerY;
          if (currentSpot != null) {
            markerX = leftAxisWidth +
                (currentSpot.x - minX) / (maxX - minX) * chartWidth;
            markerY =
                (maxY - currentSpot.y) / (maxY - minY) * chartHeight;
          }

          return Stack(
            children: [
              LineChart(
                LineChartData(
                  minX: minX,
                  maxX: maxX,
                  minY: minY,
                  maxY: maxY,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withAlpha(70),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: leftAxisWidth,
                        interval: 5,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            '${value.round()}°',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: bottomAxisHeight,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final label = labels?[value.toInt()];
                          if (label == null) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              label,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  extraLinesData: currentHourIndex != null
                      ? ExtraLinesData(
                    verticalLines: [
                      VerticalLine(
                        x: currentHourIndex!.toDouble(),
                        color: WeatherColors.accent.withValues(alpha: 0.30),
                        strokeWidth: 1,
                        dashArray: [4, 4],
                      ),
                    ],
                  )
                      : null,

                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (touchedSpot) => WeatherColors.accent,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final label = labels?[spot.x.toInt()] ?? '';
                          return LineTooltipItem(
                            '$label\n${spot.y.round()}°',
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      curveSmoothness: 0.25,
                      barWidth: 2.5,
                      color: WeatherColors.accent,
                      dotData: FlDotData(
                        show: false,
                        getDotPainter: (spot, percent, bar, index) =>
                            FlDotCirclePainter(
                              radius: 3,
                              color: Colors.white,
                              strokeWidth: 1.5,
                              strokeColor: WeatherColors.accent,
                            ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            WeatherColors.accent.withValues(alpha: 0.40),
                            WeatherColors.accent.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (markerX != null && markerY != null)
                Positioned(
                  left: markerX - 8,
                  top: markerY - 8,
                  child: _CurrentHourMarker(),
                ),
            ],
          );
        },
      ),
    );
  }

  FlSpot? _resolveCurrentSpot(List<FlSpot> spots, int currentHour) {
    for (final s in spots) {
      if (s.x.toInt() == currentHour) return s;
    }

    FlSpot? before;
    FlSpot? after;
    for (final s in spots) {
      if (s.x < currentHour) before = s;
      if (s.x > currentHour) {
        after = s;
        break;
      }
    }

    if (before != null && after != null) {
      final t = (currentHour - before.x) / (after.x - before.x);
      final y = before.y + (after.y - before.y) * t;
      return FlSpot(currentHour.toDouble(), y);
    }

    return null;
  }
}

class _CurrentHourMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: WeatherColors.accent, width: 3),
        boxShadow: [
          BoxShadow(
            color: WeatherColors.accent.withValues(alpha: 0.35),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}