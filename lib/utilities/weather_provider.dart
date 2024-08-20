import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'package:weather_stable/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  final List<Weather> _weatherList = [];
  final List<Weather> _cityWeather = [];
  final List<Weather> _detailed = [];
  List<Weather> _filteredWeatherList = [];
  List<Weather> _filteredCityList = [];

  bool _isLoading = false;

  List<Weather> get weatherList =>
      _filteredWeatherList.isNotEmpty ? _filteredWeatherList : _weatherList;

  List<Weather> get cityWeather =>
      _filteredCityList.isNotEmpty ? _filteredCityList : _cityWeather;

  List<Weather> get detailed => _detailed;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(
    String url,
    String parentElement,
    String listElement, {
    bool countryWeather = true,
    bool detailed = true,
  }) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      if (!detailed) {
        final document = parse(response.body);
        final elements = document.querySelectorAll(parentElement);
        _cityWeather.clear();
        _detailed.clear();
        _weatherList.clear();
        _filteredWeatherList.clear();
        _filteredCityList.clear();

        for (dynamic element in elements) {
          final handle = element.querySelectorAll(listElement);

          for (dynamic list in handle) {
            final a = list.querySelector('a');

            if (!countryWeather) {
              final weather = Weather(
                countryName: a?.innerHtml,
                temperature: list.querySelector('span')?.text,
                url: a?.attributes['href'],
                citiesList: a?.text,
              );

              _weatherList.add(weather);
            } else {
              final cityList = Weather(
                url: a?.attributes['href'],
                countryName: a?.innerHtml,
                temperature: list.querySelector('span')?.text,
                citiesList: a?.text,
              );

              _cityWeather.add(cityList);
            }
          }
        }
      }

      if (detailed) {
        final document = parse(response.body);
        final body = document.querySelectorAll('.weather-short');
        final today = body[0].querySelectorAll('table tr');
        final allDates = document.querySelectorAll(".dates");
        final details = Weather(
          url: 'url',
          countryName: 'countryName',
          temperature: 'temperature',
          citiesList: 'citiesList',
          rainFall: today[0].nodes[4].text,
          wind: today[0].nodes[5].text,
          humidity: today[0].nodes[6].text,
          dates: allDates,
        );
        _detailed.add(details);
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterCountries(String query) {
    if (query.isEmpty) {
      _filteredWeatherList = _weatherList;
    } else {
      _filteredWeatherList = _weatherList
          .where((weather) =>
              weather.countryName!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              weather.url!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterCities(String query) {
    if (query.isEmpty) {
      _filteredCityList = _cityWeather;
    } else {
      _filteredCityList = _cityWeather
          .where((weather) =>
              weather.citiesList!.toLowerCase().contains(query.toLowerCase()) ||
              weather.url!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
