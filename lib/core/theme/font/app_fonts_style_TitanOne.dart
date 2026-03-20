import 'package:flutter/material.dart';

class AppTextStyleTitanOne {
  static TextStyle TitanOne({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'TitanOne',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}