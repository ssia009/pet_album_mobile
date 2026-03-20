import 'package:flutter/material.dart';

class AppTextStyleCafe24Proup {
  static TextStyle Cafe24Proup({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'Cafe24Proup',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * -0.015,
    );
  }

}