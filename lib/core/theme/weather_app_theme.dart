import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/weather_app_palette.dart';

const TextStyle _bodyMedium = TextStyle(
  color: Colors.white,
  fontSize: 15,
  fontFamily: 'Cairo',
  fontWeight: FontWeight.w500,
);

const TextStyle _headlineMedium = TextStyle(
  color: Colors.white,
  fontSize: 17,
  fontFamily: 'Cairo',
  fontWeight: FontWeight.w700,
);

const TextStyle _labelMedium = TextStyle(
  color: WeatherAppPalette.mine,
  fontSize: 16,
  fontFamily: 'Cairo',
  fontWeight: FontWeight.w700,
);

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      textTheme: const TextTheme(
        headlineMedium: _headlineMedium,
        bodyMedium: _bodyMedium,
        labelMedium: _labelMedium,
      ),
    );
  }
}
