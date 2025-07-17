import 'package:flutter/material.dart';
import 'package:medigo/core/theme/text_styles.dart';

class AppTheme {
  static ThemeData build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.width / 375;
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFAF5F7), // Soft pink
      primaryColor: const Color(0xFF27C44B), // Soft highlight green
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFB6E9C9),       // Mint green for buttons
        secondary: Color(0xFF27C44B),     // Highlight
        surface: Color(0xFFFFFFFF),       // Replaces background
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1A1A1A),
        onBackground: Color(0xFF1A1A1A),
      ).copyWith(
        // Optional override if you still want to keep the old background value meaning
        surface: Color(0xFFFAF5F7),
      ),
      textTheme: AppTextTheme.getTextTheme(scaleFactor),
    );
  }
}
