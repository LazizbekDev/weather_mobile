import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationScreen extends StatelessWidget {
  final double? latitude;
  final double? longitude;

  const LocationScreen(
      {super.key, required this.latitude, required this.longitude});

  Future<String> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude!, longitude!);
      Placemark place = placemarks[0];
      print(place);
      return "${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      return "Error: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location to Address'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _getAddressFromLatLng(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('Address: ${snapshot.data}');
            }
          },
        ),
      ),
    );
  }
}
