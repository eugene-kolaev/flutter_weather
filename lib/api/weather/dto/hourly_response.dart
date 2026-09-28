
class HourlyResponse {
  List<String>? time;
  List<int>? weatherCode;
  List<double>? apparentTemperature;
  List<int>? precipitationProbability;
  List<double>? temperature2m;
  List<int>? isDay;

  HourlyResponse({this.time, this.weatherCode, this.apparentTemperature, this.precipitationProbability, this.temperature2m,this.isDay});

  HourlyResponse.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    weatherCode = json["weather_code"] == null ? null : List<int>.from(json["weather_code"]);
    apparentTemperature = json["apparent_temperature"] == null ? null : List<double>.from(json["apparent_temperature"]);
    precipitationProbability = json["precipitation_probability"] == null ? null : List<int>.from(json["precipitation_probability"]);
    temperature2m = json["temperature_2m"] == null ? null : List<double>.from(json["temperature_2m"]);
    isDay = json["is_day"] == null ? null : List<int>.from(json["is_day"]);
  }

  List<String> get formattedTimes {
    final list = time;
    if (list == null) return const [];
    return list.map(_formatTime).toList();
  }

  static String _formatTime(String iso) {
    final dt = DateTime.tryParse(iso);
    if (dt == null) return '--:--';
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(time != null) {
      _data["time"] = time;
    }
    if(weatherCode != null) {
      _data["weather_code"] = weatherCode;
    }
    if(apparentTemperature != null) {
      _data["apparent_temperature"] = apparentTemperature;
    }
    if(precipitationProbability != null) {
      _data["precipitation_probability"] = precipitationProbability;
    }
    if(temperature2m != null) {
      _data["temperature_2m"] = temperature2m;
    }
    if(isDay != null) {
      _data["temperature_2m"] = isDay;
    }
    return _data;
  }

  HourlyResponse copyWith({
    List<String>? time,
    List<int>? weatherCode,
    List<double>? apparentTemperature,
    List<int>? precipitationProbability,
    List<double>? temperature2M,
    List<int>? isDay,
  }) => HourlyResponse(
    time: time ?? this.time,
    weatherCode: weatherCode ?? this.weatherCode,
    apparentTemperature: apparentTemperature ?? this.apparentTemperature,
    precipitationProbability: precipitationProbability ?? this.precipitationProbability,
    temperature2m: temperature2m ?? this.temperature2m,
    isDay: isDay ?? this.isDay,
  );
}
