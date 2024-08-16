import 'package:flutter/material.dart';
import 'package:weather_stable/screens/city_detail.dart';
// import 'package:weather_stable/screens/splash_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: CityDetail(requestUrl: 'https://world-weather.ru/',),
      ),
    );
  }
}