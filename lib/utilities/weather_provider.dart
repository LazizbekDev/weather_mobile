import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'package:weather_stable/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  final List<Weather> _weatherList = [];
  final List<Weather> _cityWeather = [];
  bool _isLoading = false;

  List<Weather> get weatherList => _weatherList;
  List<Weather> get cityWeather => _cityWeather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(
    String url,
    String parentElement,
    String listElement, {
    bool countryWeather = true,
  }) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = parse(response.body);
      final elements = document.querySelectorAll(parentElement);
      _weatherList.clear();

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
    } else {
      _weatherList.clear();
    }

    _isLoading = false;
    notifyListeners();
  }
}
