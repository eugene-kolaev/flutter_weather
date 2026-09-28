
class DailyUnitsResponse {
  String? time;
  String? sunrise;
  String? sunset;
  String? weatherCode;

  DailyUnitsResponse({this.time, this.sunrise, this.sunset, this.weatherCode});

  DailyUnitsResponse.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
    weatherCode = json["weather_code"];
  }

  static List<DailyUnitsResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(DailyUnitsResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["sunrise"] = sunrise;
    _data["sunset"] = sunset;
    _data["weather_code"] = weatherCode;
    return _data;
  }

  DailyUnitsResponse copyWith({
    String? time,
    String? sunrise,
    String? sunset,
    String? weatherCode,
  }) => DailyUnitsResponse(
    time: time ?? this.time,
    sunrise: sunrise ?? this.sunrise,
    sunset: sunset ?? this.sunset,
    weatherCode: weatherCode ?? this.weatherCode,
  );
}
