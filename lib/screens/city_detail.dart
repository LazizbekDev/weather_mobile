import 'package:flutter/material.dart';
import 'package:weather_stable/utilities/gradient.dart';

class CityDetail extends StatelessWidget {
  const CityDetail({super.key, required this.requestUrl});
  final String requestUrl;

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
            Text(requestUrl),
          ],
        ),
      ),
    );
  }
}
