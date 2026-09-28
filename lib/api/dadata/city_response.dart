class CityResponse {
  final String value;
  final String city;
  final String regionWithType;
  final String geoLat;
  final String geoLon;

  CityResponse({required this.value, required this.city, required this.regionWithType, required this.geoLat, required this.geoLon});

  static CityResponse fromJson(Map<String, dynamic> json) {
    String value = json['value'] ?? '';
    Map<String, dynamic> dataJson = json['data'];
    String city = dataJson['city'] ?? '';
    String regionWithType = dataJson['region_with_type'] ?? '';
    String geoLat = dataJson['geo_lat']?.toString() ?? '';
    String geoLon = dataJson['geo_lon']?.toString() ?? '';
    return CityResponse(value: value, city: city, regionWithType: regionWithType, geoLat: geoLat, geoLon: geoLon);
  }
}