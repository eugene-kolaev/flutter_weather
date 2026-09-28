import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_weather/api/dadata/suggestions_response.dart';

const dadataKey = 'b151d6b61c959fe5b1a137dea0eb7f5d76b2bbf2';

Future<SuggestionsResponse> fetchCity(String q) async {
  Uri uri = Uri.parse(
    "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address",
  );
  Map<String, String> headers = {
    "Authorization": 'Token $dadataKey',
    'Content-Type': "application/json",
    'Accept': "application/json",
  };

  Map<String, dynamic> body = {
    'query': q,
    "from_bound": {"value": "city"},
    "to_bound": {"value": "city"},
  };

  String jsonBody = json.encode(body);
  final response = await http.post(uri, headers: headers, body: jsonBody);

  if (response.statusCode != 200) {
    throw Exception('Fetch request failed with message ${response.body}');
  }

  Map<String, dynamic> jsonResponse = json.decode(response.body);
  return SuggestionsResponse.fromJson(jsonResponse);
}
