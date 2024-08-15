import 'package:flutter/material.dart';
import 'package:weather_stable/utilities/app_colors.dart';

BoxDecoration gradient() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.primary, AppColors.secondary],
    ),
  );
}
