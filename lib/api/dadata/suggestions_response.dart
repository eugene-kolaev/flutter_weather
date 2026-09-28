import 'package:flutter_weather/api/dadata/city_response.dart';

class SuggestionsResponse {
  List<CityResponse> suggestions = [];

  SuggestionsResponse(this.suggestions);

  static SuggestionsResponse fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonArray = json['suggestions'];
    return SuggestionsResponse(
      jsonArray
          .map((e) => CityResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
