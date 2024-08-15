import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_stable/screens/city_weather.dart';
// import 'package:weather_stable/model/weather_model.dart';
import 'package:weather_stable/utilities/gradient.dart';
import 'package:weather_stable/utilities/weather_provider.dart';
import 'package:weather_stable/widgets/input.dart';
import 'package:weather_stable/widgets/list_items.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: gradient(),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]),
              child: const Input(),
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder<void>(
              future: Provider.of<WeatherProvider>(context, listen: false)
                  .fetchWeather(
                countryWeather: false,
                'https://world-weather.ru/pogoda/',
                '.countres',
                '.country-block',
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final weatherList =
                      Provider.of<WeatherProvider>(context).weatherList;

                  if (weatherList.isEmpty) {
                    return ListItems(
                      onClick: () {},
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: weatherList.length,
                        itemBuilder: (context, index) {
                          final weather = weatherList[index];
                          return ListTile(
                            title: ListItems(
                              text: weather.countryName ?? "No country found",
                              onClick: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return CityWeather(
                                        requestUrl: weather.url ??
                                            "No URL for this country",
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
