import 'package:flutter/material.dart';

class AppTextStyleGoryung {
  static TextStyle Goryung({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'Goryung',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}