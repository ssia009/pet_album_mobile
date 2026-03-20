import 'package:flutter/material.dart';

class AppTextStyleIndieFlower {
  static TextStyle IndieFlower({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}