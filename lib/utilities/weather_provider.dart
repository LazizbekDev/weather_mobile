import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'package:weather_stable/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  final List<Weather> _weatherList = [];
  bool _isLoading = false;

  List<Weather> get weatherList => _weatherList;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(
    String url,
    String parentElement,
    String listElement,
  ) async {
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

          final weather = Weather(
            cityName: a?.innerHtml,
            temperature: list.querySelector('span')?.text,
            url: a?.attributes['href'],
            countriesList: a?.text,
            countryTemperature: list.querySelector('span')?.text,
          );
          // print(a?.innerHtml);

          _weatherList.add(weather);
        }
      }
    } else {
      _weatherList.clear();
    }

    _isLoading = false;
    notifyListeners();
  }
}
