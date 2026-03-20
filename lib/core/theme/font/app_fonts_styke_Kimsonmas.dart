import 'package:flutter/material.dart';

class AppTextStyleKimsonmas {
  static TextStyle Kimsonmas({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'Kimsonmas',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}