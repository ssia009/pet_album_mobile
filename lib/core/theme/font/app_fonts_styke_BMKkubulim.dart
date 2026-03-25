import 'package:flutter/material.dart';

class AppTextStyleBMKkubulim {
  static TextStyle BMKkubulim({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'BMKkubulim',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}