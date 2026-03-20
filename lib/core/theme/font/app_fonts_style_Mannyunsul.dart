import 'package:flutter/material.dart';

class AppTextStyleManyunsul {
  static TextStyle Manyunsul({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'Manyunsul',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}