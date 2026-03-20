import 'package:flutter/material.dart';

class AppTextStyleBookkMyungjo {
  static TextStyle BookkMyungjo({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'BookkMyungjo',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}