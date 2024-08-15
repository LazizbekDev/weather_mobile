import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_stable/utilities/app_colors.dart';

class ListItems extends StatelessWidget {
  final String text;
  final String celsius;
  final Function() onClick;

  const ListItems({
    super.key,
    this.text = "No country found!",
    this.celsius = "",
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: const Color(0x61FFFFFF),
      elevation: 0,
      highlightElevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 23),
      onPressed: onClick,
      child: Row(
        mainAxisAlignment: celsius != "" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: AppColors.gray,
            ),
          ),
          Text(
            celsius,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}
