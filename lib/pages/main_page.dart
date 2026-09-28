import 'package:flutter/material.dart';
import 'package:flutter_weather/api/dadata/city_response.dart';
import 'package:flutter_weather/api/weather/dto/weather_response.dart';
import 'package:flutter_weather/api/weather/fetch/fetch_weather.dart';
import 'package:flutter_weather/commons/weather_colors.dart';
import 'package:flutter_weather/components/astronomy_widget.dart';
import 'package:flutter_weather/components/change_of_rain_widget.dart';
import 'package:flutter_weather/components/day_forecast_widget.dart';
import 'package:flutter_weather/components/day_summary_widget.dart';
import 'package:flutter_weather/components/hourly_forecast_widget.dart';
import 'package:flutter_weather/components/main_temp_widget.dart';
import 'package:flutter_weather/components/navigation_buttons_widget.dart';
import 'package:flutter_weather/pages/search_page.dart';

enum MainPageView { today, tomorrow, nextWeek, search }

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainPageView currentView = MainPageView.today;
  CityResponse? currentCity;
  late Future<WeatherResponse>? weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = fetchWeather();
  }

  _onSwitchView(MainPageView view) {
    setState(() {
      currentView = view;
    });
  }

  _onCityChanged(CityResponse cityResponse) {
    setState(() {
      currentCity = cityResponse;
      currentView = MainPageView.today;
      weatherData = fetchWeather(
        latitude: double.tryParse(cityResponse.geoLat),
        longitude: double.tryParse(cityResponse.geoLon),
      );
    });
  }

  void _reload() {
    setState(() {
      weatherData = currentCity == null
          ? fetchWeather()
          : fetchWeather(
        latitude: double.tryParse(currentCity!.geoLat),
        longitude: double.tryParse(currentCity!.geoLon),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    late Widget content;
    if (currentView == MainPageView.search) {
      content = SearchPage(onChanged: _onCityChanged);
    } else if (currentView == MainPageView.today) {
      content = today();
    } else if (currentView == MainPageView.tomorrow) {
      content = tomorrow();
    } else {
      content = nextWeek();
    }

    return Scaffold(
      backgroundColor: WeatherColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(currentCity?.city ?? 'Моё местоположение'),
        backgroundColor: WeatherColors.second,
        actions: [
          IconButton(
            onPressed: () {
              if (currentView == MainPageView.search) {
                _onSwitchView(MainPageView.today);
              } else {
                _onSwitchView(MainPageView.search);
              }
            },
            icon: currentView == MainPageView.search
                ? const Icon(Icons.close)
                : Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(child: content),
    );
  }

  Widget _buildWeatherContent(Widget Function(WeatherResponse) builder) {
    return FutureBuilder<WeatherResponse>(
      future: weatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            color: WeatherColors.background,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            color: WeatherColors.background,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 12),
                Text(
                  'Не удалось загрузить погоду',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '${snapshot.error ?? "Нет данных"}',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _reload,
                  child: const Text('Повторить'),
                ),
              ],
            ),
          );
        }

        return builder(snapshot.data!);
      },
    );
  }

  // ——— Вкладки ———

  Widget today() {
    return _buildWeatherContent((weather) => Container(
      color: WeatherColors.background,
      child: ListView(
        children: [
          MainTempWidget(
            tempC: weather.current!.temperature2M!.toInt(),
            feelsLikeTempC: weather.current!.apparentTemperature!.toInt(),
            weatherResponse: weather,
          ),
          NavigationButtonsWidget(
            onTap: _onSwitchView,
            current: currentView,
          ),
          HourlyForecastWidget(hourlyResponse: weather.hourly!),
          DayForecastWidget(hourlyResponse: weather.hourly!),
          ChangeOfRainWidget(hourlyResponse: weather.hourly!),
        ],
      ),
    ));
  }

  Widget tomorrow() {
    return _buildWeatherContent((weather) => Container(
      color: WeatherColors.background,
      child: ListView(
        children: [
          NavigationButtonsWidget(
            onTap: _onSwitchView,
            current: currentView,
          ),
          AstronomyWidget(dailyResponse: weather.daily!, isTomorrow: true,),
          HourlyForecastWidget(key: const ValueKey('tomorrow'),hourlyResponse: weather.hourly!, isTomorrow: true),
          DayForecastWidget(hourlyResponse: weather.hourly!, isTomorrow: true,),
          ChangeOfRainWidget(hourlyResponse: weather.hourly!, isTomorrow: true,),
        ],
      ),
    ));
  }

  Widget nextWeek() {

    return _buildWeatherContent((weather) => Container(
      color: WeatherColors.background,
      child: ListView(
        children: [
          NavigationButtonsWidget(
            onTap: _onSwitchView,
            current: currentView,
          ),
          DaySummaryWidget(dailyResponse: weather.daily!),
        ],
      ),
    ));
  }
}
