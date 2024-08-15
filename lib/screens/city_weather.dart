import 'package:flutter/material.dart';

class CityWeather extends StatelessWidget {
  const CityWeather({super.key, required this.requestUrl});
  final String requestUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(requestUrl),
      ),
    );
  }
}
