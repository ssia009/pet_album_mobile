import 'package:flutter/material.dart';

class AppTextStyleZenSerif {
  static TextStyle ZenSerif({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'ZenSerif',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}