import 'package:flutter/material.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(centerTitle: true),
    brightness: Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: Colors.red,
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(
          Size(40.0, 40.0),
        ),
      ),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(centerTitle: true),
    brightness: Brightness.dark,
    useMaterial3: true,
    colorSchemeSeed: Colors.red,
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(
          Size(40.0, 40.0),
        ),
      ),
    ),
  );
}
