import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: const Color(0xFFF5F5F0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFF1E2637),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
