
class HourlyUnitsResponse {
  String? time;
  String? weatherCode;
  String? apparentTemperature;
  String? precipitationProbability;
  String? temperature2M;

  HourlyUnitsResponse({this.time, this.weatherCode, this.apparentTemperature, this.precipitationProbability, this.temperature2M});

  HourlyUnitsResponse.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    weatherCode = json["weather_code"];
    apparentTemperature = json["apparent_temperature"];
    precipitationProbability = json["precipitation_probability"];
    temperature2M = json["temperature_2m"];
  }

  static List<HourlyUnitsResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(HourlyUnitsResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["weather_code"] = weatherCode;
    _data["apparent_temperature"] = apparentTemperature;
    _data["precipitation_probability"] = precipitationProbability;
    _data["temperature_2m"] = temperature2M;
    return _data;
  }

  HourlyUnitsResponse copyWith({
    String? time,
    String? weatherCode,
    String? apparentTemperature,
    String? precipitationProbability,
    String? temperature2M,
  }) => HourlyUnitsResponse(
    time: time ?? this.time,
    weatherCode: weatherCode ?? this.weatherCode,
    apparentTemperature: apparentTemperature ?? this.apparentTemperature,
    precipitationProbability: precipitationProbability ?? this.precipitationProbability,
    temperature2M: temperature2M ?? this.temperature2M,
  );
}