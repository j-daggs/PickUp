import 'package:flutter/material.dart';

/// ----  Green Theme  ----
const greenPrimary = Color.fromARGB(255, 30, 107, 33);
const primaryLight = Color.fromARGB(255, 50, 180, 55);
const primaryLightLowAlpha = Color.fromARGB(80, 42, 154, 46);
const primaryAccent = Color.fromARGB(255, 240, 162, 6);

const blackText = Color.fromARGB(255, 0, 0, 0);
const lightText = Color.fromARGB(255, 85, 85, 85);
const brightText = Color.fromARGB(255, 255, 255, 255);

const brightColor = Color.fromARGB(255, 255, 255, 255);
const lightColor = Color.fromARGB(255, 85, 85, 85);
const darkColor = Color.fromARGB(255, 0, 0, 0);
const errorColor = Color.fromARGB(255, 255, 0, 0);

const brightBackground = Color.fromARGB(255, 255, 255, 255);
const lightBackground = Color.fromARGB(255, 194, 190, 190);
const darkBackground = Color.fromARGB(255, 0, 0, 0);

const double headerFontSize = 20;
const double bodyFontSize = 15;
const double largeFontSize = 25;

const double maxFieldWidth = 0.6;
const double maxButtonWidth = 0.6;

class AppTheme {
  // this is how it is supposed to be themed but i ran into so many issues
  // and now i am using this because some pre-packed widgets do not
  // like my method of theming. i still use these to override widget themeing that
  // cannot be directly accessed with attributes.
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
