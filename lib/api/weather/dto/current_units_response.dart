
class CurrentUnitsResponse {
  String? time;
  String? interval;
  String? temperature2M;
  String? apparentTemperature;

  CurrentUnitsResponse({this.time, this.interval, this.temperature2M, this.apparentTemperature});

  CurrentUnitsResponse.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    interval = json["interval"];
    temperature2M = json["temperature_2m"];
    apparentTemperature = json["apparent_temperature"];
  }

  static List<CurrentUnitsResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(CurrentUnitsResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["interval"] = interval;
    _data["temperature_2m"] = temperature2M;
    _data["apparent_temperature"] = apparentTemperature;
    return _data;
  }

  CurrentUnitsResponse copyWith({
    String? time,
    String? interval,
    String? temperature2M,
    String? apparentTemperature,
  }) => CurrentUnitsResponse(
    time: time ?? this.time,
    interval: interval ?? this.interval,
    temperature2M: temperature2M ?? this.temperature2M,
    apparentTemperature: apparentTemperature ?? this.apparentTemperature,
  );
}