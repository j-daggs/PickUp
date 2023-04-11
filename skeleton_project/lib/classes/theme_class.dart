import 'dart:ui';
import 'package:flutter/material.dart';

/// ----  Green Theme  ----
const greenPrimary = Color(0xFF4CAF50);
const greenAccent = Color.fromARGB(255, 255, 213, 0);
const greenBackground = Color.fromARGB(255, 218, 218, 218);
const textColor = Color.fromARGB(255, 0, 0, 0);
final greenTheme = ThemeData(
    primaryColor: greenPrimary,
    highlightColor: greenAccent,
    scaffoldBackgroundColor: greenBackground,
    primaryColorDark: textColor);
