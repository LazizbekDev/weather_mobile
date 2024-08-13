import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_stable/screens/search.dart';
import 'package:weather_stable/utilities/app_colors.dart';
import 'package:weather_stable/utilities/gradient.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: gradient(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 70),
          Image.asset('assets/images/main.png', width: 300),
          const SizedBox(height: 32.5),
          Text(
            "World's weather App",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.main,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.5),
          MaterialButton(
            color: AppColors.alphaLight,
            height: 38,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return const Search();
                }),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 18,
              ),
              child: Text("Click to find your town",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: AppColors.gray,
                  ),
                  textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
