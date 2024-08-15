import 'package:flutter/material.dart';
import 'package:weather_stable/utilities/app_colors.dart';

class Status extends StatelessWidget {
  final double width;
  final String src;
  final String time;
  final String celsius;
  final bool active;
  const Status({
    super.key,
    this.width = 50,
    this.src = 'assets/images/SunWindy.png',
    this.time = "now",
    this.celsius = '',
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 32,
      height: 56,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: active ? const Color(0xB2FFFFFF) : const Color(0x4DFFFFFF),
      elevation: 0,
      highlightElevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      onPressed: () {},
      child: SizedBox(
        width: 32,
        height: 56,
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                color: active ? AppColors.main : const Color(0xFF9C9EAA),
                fontSize: 10,
              ),
            ),
            const SizedBox(
              height: 3.3,
            ),
            Image.asset(
              src,
              width: width,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              celsius,
              style: const TextStyle(
                color: AppColors.main,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
