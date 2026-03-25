import 'package:flutter/material.dart';

class AppTextStyleYoonChild {
  static TextStyle YoonChild({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'YoonChild',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}