
class DailyResponse {
  List<String>? time;
  List<String>? sunrise;
  List<String>? sunset;
  List<int>? weatherCode;
  List<double>? temperature2mMax;
  List<double>? temperature2mMin;

  DailyResponse({this.time, this.sunrise, this.sunset, this.weatherCode, this.temperature2mMax, this.temperature2mMin});

  DailyResponse.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    sunrise = _mapTimes(json["sunrise"]);
    sunset  = _mapTimes(json["sunset"]);
    weatherCode = json["weather_code"] == null ? null : List<int>.from(json["weather_code"]);
    temperature2mMax = json["temperature_2m_max"] == null ? null : List<double>.from(json["temperature_2m_max"]);
    temperature2mMin = json["temperature_2m_min"] == null ? null : List<double>.from(json["temperature_2m_min"]);
  }


  static const _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];



  List<String> get formattedDates {
    final list = time;
    if (list == null) return const [];
    return list.map(_formatDate).toList();
  }



  static String _formatDate(String iso) {
    final dt = DateTime.tryParse(iso);
    if (dt == null) return '--';
    final month = _monthNames[dt.month - 1];
    return '$month ${dt.day}';
  }




  static List<String>? _mapTimes(dynamic raw) {
    if (raw == null) return null;
    return List<String>.from(raw).map(_formatTime).toList();
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
    if(sunrise != null) {
      _data["sunrise"] = sunrise;
    }
    if(sunset != null) {
      _data["sunset"] = sunset;
    }
    if(weatherCode != null) {
      _data["weather_code"] = weatherCode;
    }
    return _data;
  }

}
