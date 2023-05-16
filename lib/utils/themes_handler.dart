import 'package:flutter/material.dart';

abstract class ThemesHandler {
  static final light = ThemeData.from(
    colorScheme: const ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.greenAccent,
    ),
    useMaterial3: true,
  );
}
