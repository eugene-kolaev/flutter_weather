import 'package:flutter/material.dart';
import 'package:flutter_weather/api/weather/dto/hourly_response.dart';
import 'package:flutter_weather/components/card_title_widget.dart';
import 'package:flutter_weather/components/card_widget.dart';
import 'package:flutter_weather/components/container_widget.dart';
import 'package:flutter_weather/components/hourly_forecast_item_widget.dart';

class HourlyForecastWidget extends StatefulWidget {
  final HourlyResponse hourlyResponse;
  final int hoursToShow;
  final int? startIndexOverride;
  final bool isTomorrow;

  const HourlyForecastWidget({
    super.key,
    required this.hourlyResponse,
    this.hoursToShow = 18,
    this.startIndexOverride,
    this.isTomorrow = false,
  });

  @override
  State<HourlyForecastWidget> createState() => _HourlyForecastWidgetState();
}




class _HourlyForecastWidgetState extends State<HourlyForecastWidget> {
  static const double _itemWidth = 64;
  static const double _separatorWidth = 8;
  static const double _paddingLeft = 8;

  // На каком часе раскрывать скролл для «Завтра»
  static const int _scrollToHour = 8;

  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();

    final initialOffset = widget.isTomorrow
        ? _paddingLeft +
        _scrollToHour * (_itemWidth + _separatorWidth)
        : 0.0;

    _controller = ScrollController(initialScrollOffset: initialOffset);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final times = widget.hourlyResponse.formattedTimes;
    final codes = widget.hourlyResponse.weatherCode ?? const <int>[];
    final temps = widget.hourlyResponse.temperature2m ?? const <double>[];

    final available = [
      times.length,
      codes.length,
      temps.length,
    ].reduce((a, b) => a < b ? a : b);

    // final startIndex = widget.startIndexOverride ?? _findCurrentHourIndex();
    //
    // final count = (available - startIndex).clamp(0, widget.hoursToShow);
    if (available == 0) return const SizedBox.shrink();

    final startIndex = widget.startIndexOverride ??
        (widget.isTomorrow
            ? _findTomorrowStartIndex()
            : _findCurrentHourIndex());

    final limit = widget.isTomorrow ? 24 : widget.hoursToShow;
    final count = (available - startIndex).clamp(0, limit);


    return ContainerWidget(
      child: CardWidget(
        child: Column(
          children: [
            CardTitleWidget(
              icon: Icons.access_time_rounded,
              title: widget.isTomorrow ? "Tomorrow" : "Hourly forecast",
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.separated(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: count,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final endIndex = startIndex + i;
                  return SizedBox(
                    width: 64,
                    child: HourlyForecastItemWidget(
                      hourlyResponse: widget.hourlyResponse,
                      index: endIndex,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _findCurrentHourIndex() {
    final raw = widget.hourlyResponse.time;
    if (raw == null || raw.isEmpty) return 0;

    final now = DateTime.now();

    for (var i = 0; i < raw.length; i++) {
      final dt = DateTime.tryParse(raw[i]);
      if (dt == null) continue;

      if (dt.year == now.year &&
          dt.month == now.month &&
          dt.day == now.day &&
          dt.hour == now.hour) {
        return i + 1;
      }
    }

    for (var i = 0; i < raw.length; i++) {
      final dt = DateTime.tryParse(raw[i]);
      if (dt == null) continue;

      if (!dt.isBefore(now)) {
        final isCurrentHour = dt.year == now.year &&
            dt.month == now.month &&
            dt.day == now.day &&
            dt.hour == now.hour;
        return isCurrentHour ? i + 1 : i;
      }
    }

    return 0;
  }

  int _findTomorrowStartIndex() {
    final raw = widget.hourlyResponse.time;
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