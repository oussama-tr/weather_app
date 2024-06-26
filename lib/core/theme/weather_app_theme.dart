import 'package:flutter/material.dart';

class AppTheme {
  static const TextStyle _bodyMedium = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle _headlineMedium = TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w700,
  );

  static ThemeData get theme {
    return ThemeData(
      textTheme: const TextTheme(
        headlineMedium: _headlineMedium,
        bodyMedium: _bodyMedium,
      ),
    );
  }
}
