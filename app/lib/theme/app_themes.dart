import 'package:flutter/material.dart';

class AppThemes {
  static final devnology = ThemeData(
    primaryColor: Colors.green,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    cardColor: Colors.green.shade50,
  );

  static final in8 = ThemeData(
    primaryColor: Colors.purple,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.purple,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    ),
    cardColor: Colors.purple.shade50,
  );
}
