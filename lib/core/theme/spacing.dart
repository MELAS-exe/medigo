import 'package:flutter/material.dart';

class AppSpacing {
  static double space4(BuildContext context) => _scale(context, 4);
  static double space8(BuildContext context) => _scale(context, 8);
  static double space16(BuildContext context) => _scale(context, 16);
  static double space32(BuildContext context) => _scale(context, 32);
  static double space64(BuildContext context) => _scale(context, 64);

  static double _scale(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    return size * (screenWidth / 375); // Scale to device width
  }
}
