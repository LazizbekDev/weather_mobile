import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_stable/screens/city_detail.dart';
import 'package:weather_stable/utilities/gradient.dart';
import 'package:weather_stable/utilities/weather_provider.dart';
import 'package:weather_stable/widgets/input.dart';
import 'package:weather_stable/widgets/list_items.dart';

class CityWeather extends StatelessWidget {
  const CityWeather({super.key, required this.requestUrl});
  final String requestUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: gradient(),
        child: FutureBuilder<void>(
          future:
              Provider.of<WeatherProvider>(context, listen: false).fetchWeather(
            requestUrl,
            '.cities',
            '.city-block',
            countryWeather: true,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final cityList =
                  Provider.of<WeatherProvider>(context).cityWeather;

              return Column(children: [
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
                Expanded(
                  child: ListView.builder(
                    itemCount: cityList.length,
                    itemBuilder: (context, index) {
                      final weather = cityList[index];
                      return ListTile(
                        title: ListItems(
                          text: weather.citiesList ?? "No country found",
                          celsius: weather.temperature ?? "",
                          onClick: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return CityDetail(
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
                )
              ]);
            }
          },
        ),
      ),
    );
  }
}
