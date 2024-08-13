import 'package:flutter/material.dart';
import 'package:weather_stable/utilities/app_colors.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0x70FFFFFF),
        prefixIcon: Icon(Icons.search),
        hintText: "Enter city name",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.alphaLight,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00FFFFFF),
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
      ),
    );
  }
}
