import 'package:flutter/material.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      fontFamily: 'Suit',
      textTheme: appTextTheme,
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
    );
  }
}