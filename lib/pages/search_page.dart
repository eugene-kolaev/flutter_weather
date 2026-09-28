import 'package:flutter/material.dart';
import 'package:flutter_weather/api/dadata/city_response.dart';
import 'package:flutter_weather/api/dadata/fetch_city.dart';
import 'package:flutter_weather/api/dadata/suggestions_response.dart';
import 'package:flutter_weather/commons/weather_colors.dart';
import 'package:flutter_weather/components/city_search_item_widget.dart';
import 'package:flutter_weather/components/search_widget.dart';

class SearchPage extends StatefulWidget {
  final Function(CityResponse cityResponse) onChanged;

  const SearchPage({super.key, required this.onChanged});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';
  Future<SuggestionsResponse>? data;

  void _onChanged(String text) {
    setState(() {
      searchText = text;
    });
  }

  void _onSearch() {
    setState(() {
      data = fetchCity(searchText);
    });
  }

  void _onChooseCity(CityResponse cityResponse) {
    widget.onChanged(cityResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WeatherColors.second,
      child: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          List<Widget> content = [];
          content.add(SearchWidget(onChanged: _onChanged, onTap: _onSearch));
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
            SuggestionsResponse suggestionsResponse = snapshot.data!;
            for(CityResponse cityResponse in suggestionsResponse.suggestions) {
              content.add(CitySearchItemWidget(cityResponse: cityResponse, onTap: _onChooseCity));
            }
          }

          return ListView(children: content);
        },
      ),
    );
  }
}
