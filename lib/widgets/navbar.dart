import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_stable/utilities/app_colors.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStateColor.transparent,
          ),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 20,
            color: AppColors.main,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        ),
        ),
        const SizedBox(
          width: 50,
        )
      ],
    );
  }
}
