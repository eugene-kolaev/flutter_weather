import 'package:flutter/material.dart';
import 'package:flutter_weather/components/button_widget.dart';
import 'package:flutter_weather/components/container_widget.dart';
import 'package:flutter_weather/pages/main_page.dart';

class NavigationButtonsWidget extends StatelessWidget {
  final Function(MainPageView view) onTap;
  final MainPageView current;

  const NavigationButtonsWidget({
    super.key,
    required this.onTap,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      child: Row(
        children: [
          ButtonWidget(
            isActive: current == MainPageView.today,
            text: 'Today',
            onTap: () {
              onTap(MainPageView.today);
            },
          ),
          Expanded(child: Container()),
          ButtonWidget(
            isActive: current == MainPageView.tomorrow,
            text: 'Tomorrow',
            onTap: () {
              onTap(MainPageView.tomorrow);
            },
          ),
          Expanded(child: Container()),
          ButtonWidget(
            isActive: current == MainPageView.nextWeek,
            text: '7 days',
            onTap: () {
              onTap(MainPageView.nextWeek);
            },
          ),
        ],
      ),
    );
  }
}
