import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_stable/screens/city_detail.dart';
import 'package:weather_stable/utilities/gradient.dart';
import 'package:weather_stable/utilities/weather_provider.dart';
import 'package:weather_stable/widgets/input.dart';
import 'package:weather_stable/widgets/list_items.dart';
import 'package:weather_stable/widgets/navbar.dart';

class CityWeather extends StatefulWidget {
  const CityWeather({
    super.key,
    required this.requestUrl,
    required this.countryName,
  });
  final String requestUrl;
  final String countryName;

  @override
  State<CityWeather> createState() => _CityWeatherState();
}

class _CityWeatherState extends State<CityWeather> {
  final TextEditingController _controller = TextEditingController();
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
            widget.requestUrl,
            '.cities',
            '.city-block',
            countryWeather: true,
            detailed: false,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red[400]),
                ),
              );
            } else {
              final cityList =
                  Provider.of<WeatherProvider>(context).cityWeather;

              return SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Navbar(text: widget.countryName),
                    const SizedBox(
                      height: 30,
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
                      child: Input(
                        controller: _controller,
                        onChange: (query) {
                          Provider.of<WeatherProvider>(context, listen: false)
                              .filterCities(query);
                        },
                      ),
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
                            contentPadding: EdgeInsets.zero,
                            title: ListItems(
                              text: weather.citiesList ?? "No country found",
                              celsius: weather.temperature ?? "",
                              height: 70,
                              onClick: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return CityDetail(
                                        requestUrl: weather.url ??
                                            "No URL for this country",
                                        cityName:
                                            weather.citiesList ?? "Unknown",
                                        celsius: weather.temperature ?? "",
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
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
