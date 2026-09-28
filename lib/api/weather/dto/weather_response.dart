
import 'package:flutter_weather/api/weather/dto/current_response.dart';
import 'package:flutter_weather/api/weather/dto/current_units_response.dart';

import 'daily_response.dart';
import 'daily_units_response.dart';
import 'hourly_response.dart';
import 'hourly_units_response.dart';

class WeatherResponse {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentUnitsResponse? currentUnits;
  CurrentResponse? current;
  HourlyUnitsResponse? hourlyUnits;
  HourlyResponse? hourly;
  DailyUnitsResponse? dailyUnits;
  DailyResponse? daily;

  WeatherResponse(
      {this.latitude,
        this.longitude,
        this.generationtimeMs,
        this.utcOffsetSeconds,
        this.timezone,
        this.timezoneAbbreviation,
        this.elevation,
        this.currentUnits,
        this.current,
        this.hourlyUnits,
        this.hourly,
        this.dailyUnits,
        this.daily});

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    currentUnits = json['current_units'] != null
        ? new CurrentUnitsResponse.fromJson(json['current_units'])
        : null;
    current =
    json['current'] != null ? new CurrentResponse.fromJson(json['current']) : null;
    hourlyUnits = json['hourly_units'] != null
        ? new HourlyUnitsResponse.fromJson(json['hourly_units'])
        : null;
    hourly =
    json['hourly'] != null ? new HourlyResponse.fromJson(json['hourly']) : null;
    dailyUnits = json['daily_units'] != null
        ? new DailyUnitsResponse.fromJson(json['daily_units'])
        : null;
    daily = json['daily'] != null ? new DailyResponse.fromJson(json['daily']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['generationtime_ms'] = this.generationtimeMs;
    data['utc_offset_seconds'] = this.utcOffsetSeconds;
    data['timezone'] = this.timezone;
    data['timezone_abbreviation'] = this.timezoneAbbreviation;
    data['elevation'] = this.elevation;
    if (this.currentUnits != null) {
      data['current_units'] = this.currentUnits!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    if (this.hourlyUnits != null) {
      data['hourly_units'] = this.hourlyUnits!.toJson();
    }
    if (this.hourly != null) {
      data['hourly'] = this.hourly!.toJson();
    }
    if (this.dailyUnits != null) {
      data['daily_units'] = this.dailyUnits!.toJson();
    }
    if (this.daily != null) {
      data['daily'] = this.daily!.toJson();
    }
    return data;
  }
}


