import 'package:flutter/material.dart';

abstract class AppData {
  const AppData();

  static const userRole = 'manager';

  static const String appName = 'City Queen Manager';

  static const btnTextColor = Colors.white;

  static const mainColorValue = 0xFF726CF8;
  static const secondaryColorValue = 0xFFE975A8;

  static const mainColor = Color(mainColorValue);
  static const secondaryColor = Color(secondaryColorValue);

  static List<Color> get colorsList {
    return [secondaryColor, mainColor];
  }

  static Gradient get gradient {
    return LinearGradient(colors: colorsList);
  }

  static Gradient get customGradient {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colorsList,
    );
  }
}
