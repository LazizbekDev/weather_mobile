import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_stable/screens/home.dart';
import 'package:weather_stable/utilities/weather_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const Home(),
    ),
  ); 
}
