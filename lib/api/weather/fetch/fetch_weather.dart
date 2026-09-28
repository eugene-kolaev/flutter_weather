import 'dart:convert';
import 'package:flutter_weather/api/weather/dto/weather_response.dart';
import 'package:flutter_weather/services/location_service.dart';
import 'package:http/http.dart' as http;

const weatherHost = "https://api.open-meteo.com/v1/forecast?";

const _defaultLatitude = 55.7558;
const _defaultLongitude = 37.6173;

Future<WeatherResponse> fetchWeather({double? latitude, double? longitude}) async {
  if (latitude == null || longitude == null) {
    final location = await LocationService.getCurrent();

    if (location is LocationSuccess) {
      latitude = location.latitude;
      longitude = location.longitude;
    } else {
      latitude = _defaultLatitude;
      longitude = _defaultLongitude;
    }
  }


  Uri uri = Uri.parse(
    "$weatherHost"
    "latitude=$latitude"
    "&longitude=$longitude"
    "&daily=sunrise,sunset,weather_code,temperature_2m_max,temperature_2m_min"
    "&hourly=weather_code,apparent_temperature,precipitation_probability,temperature_2m,is_day&current=temperature_2m,apparent_temperature&timezone=Europe%2FMoscow",
  );
  Map<String, String> header = {
    'Content-Type': 'application/json; charset=utf-8',
  };

  final response = await http.get(uri, headers: header);

  if (response.statusCode != 200) {
    throw Exception(
      'Fetch weather data failed: ${response.statusCode} ${response.body}',
    );
  }

  Map<String, dynamic> jsonData = json.decode(response.body);

  return WeatherResponse.fromJson(jsonData);
}
