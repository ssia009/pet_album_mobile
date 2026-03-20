import 'package:flutter/material.dart';

class AppTextStyleCaveat {
  static TextStyle Caveat({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'Caveat',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}