import 'package:flutter/material.dart';

class AppTextStyleTAEBAEK {
  static TextStyle TAEBAEK({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'TAEBAEK',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}