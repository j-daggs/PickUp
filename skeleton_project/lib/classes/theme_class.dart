import 'dart:ui';
import 'package:flutter/material.dart';

/// ----  Green Theme  ----
const greenPrimary = Color.fromARGB(255, 33, 122, 36);
const primaryLight = Color.fromARGB(255, 42, 154, 46);
const primaryAccent = Color.fromARGB(166, 255, 170, 0);

const blackText = Color.fromARGB(255, 0, 0, 0);
const lightText = Color.fromARGB(255, 85, 85, 85);
const brightText = Color.fromARGB(255, 255, 255, 255);

const brightColor = Color.fromARGB(255, 255, 255, 255);
const errorColor = Color.fromARGB(255, 255, 0, 0);

const brightBackground = Color.fromARGB(255, 255, 255, 255);
const lightBackground = Color.fromARGB(255, 194, 190, 190);
const darkBackground = Color.fromARGB(255, 0, 0, 0);

const double headerFontSize = 20;
const double bodyFontSize = 15;

class AppTheme {
  // this is how it is supposed to be themed but i ran into so many issues
  // and now i am using this because some pre-packed widgets do not
  // like my method of theming
  //
  // its not janky if it's a school project
  static final ThemeData greenTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: greenPrimary,
      onPrimary: brightColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: brightText,
        fontWeight: FontWeight.bold,
        fontSize: headerFontSize,
      ),
    ),
  );
}
