import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme getTextTheme(double scaleFactor) {
    return TextTheme(
      labelSmall: TextStyle(fontSize: 10 * scaleFactor),
      bodySmall: TextStyle(fontSize: 12 * scaleFactor),
      bodyMedium: TextStyle(fontSize: 14 * scaleFactor, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: 18 * scaleFactor, fontWeight: FontWeight.bold),
    );
  }
}
