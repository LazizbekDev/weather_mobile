import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:weather_stable/screens/city_detail.dart';
import 'package:weather_stable/utilities/gradient.dart';
import 'package:weather_stable/utilities/weather_provider.dart';
import 'package:weather_stable/widgets/input.dart';
import 'package:weather_stable/widgets/list_items.dart';
import 'package:weather_stable/widgets/navbar.dart';

class LocationScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const LocationScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<List<dynamic>> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(widget.latitude!, widget.longitude!);
      Placemark place = placemarks[0];

      // ignore: use_build_context_synchronously
      await Provider.of<WeatherProvider>(context, listen: false).fetchWeather(
        'https://world-weather.ru/pogoda/${place.country == "United State" ? "USA" : place.country == "O`zbekiston" ? "uzbekistan" : place.country}',
        '.cities',
        '.city-block',
        countryWeather: true,
        detailed: false,
      );

      return [place.country, Provider.of<WeatherProvider>(context, listen: false).cityWeather];
    } catch (e) {
      throw "Error: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: gradient(),
        child: FutureBuilder(
          future: _getAddressFromLatLng(),
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
            } else if (snapshot.hasData && snapshot.data != null) {
              return SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Navbar(text: snapshot.data![0] as String),
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
                        itemCount: (snapshot.data![1] as List).length,
                        itemBuilder: (context, index) {
                          final weather = snapshot.data![1][index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: ListItems(
                              text: weather.citiesList ?? "No city found",
                              celsius: weather.temperature ?? "",
                              height: 70,
                              onClick: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return CityDetail(
                                        requestUrl: weather.url ??
                                            "No URL for this city",
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
            } else {
              return const Center(
                child: Text(
                  'No data available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
