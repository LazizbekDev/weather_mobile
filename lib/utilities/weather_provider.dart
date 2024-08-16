import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'package:weather_stable/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  final List<Weather> _weatherList = [];
  final List<Weather> _cityWeather = [];
  List<Weather> _detailed = [];
  bool _isLoading = false;

  List<Weather> get weatherList => _weatherList;
  List<Weather> get cityWeather => _cityWeather;
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
        // final titleBar = document.querySelectorAll('.weather-today tr');
        // final day = titleBar[0].querySelector('#weather-day')?.text;
        // final temperature =
        //     titleBar[0].querySelector('#weather-temperature')?.text;
        // final feeling = titleBar[0].querySelector('#weather-feeling')?.text;
        // final probability =
        //     titleBar[0].querySelector('#weather-probability')?.text;
        // final pressure = titleBar[0].querySelector('#weather-pressure')?.text;
        // final wind = titleBar[0].querySelector('#weather-wind')?.text;
        // final humidity = titleBar[0].querySelector('#weather-humidity')?.text;
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
        print(allDates[0].text);
        // _weatherList.clear();
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
