import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_stable/utilities/app_colors.dart';

class ListItems extends StatelessWidget {
  final String text;
  final String celsius;
  final String src;
  final double width;
  final double height;
  final Function() onClick;

  const ListItems({
    super.key,
    this.text = "No country found!",
    this.celsius = "",
    this.src = "",
    this.width = 40,
    this.height = 40,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: const Color(0x61FFFFFF),
      elevation: 0,
      highlightElevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      onPressed: onClick,
      child: Row(
        mainAxisAlignment: celsius != ""
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: <Widget>[
          if (src != "")
            Row(
              children: [
                Image.asset(
                  src,
                  width: width,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray,
                  ),
                ),
              ],
            )
          else
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
