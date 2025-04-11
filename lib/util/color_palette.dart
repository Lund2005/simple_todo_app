import 'package:flutter/material.dart';

/*
This class implements an easy attempt to store the app's colors in a color
pallette like fashion. It therefore is an easy and beginner-friendly alternative
for flutters build in color system.
*/

class ColorPalette {
  static Color primary = const Color.fromARGB(255, 126, 83, 255);
  static Color secondary = Color.fromARGB(255, 45, 45, 45);
  static Color tertiary = Color.fromARGB(255, 161, 161, 161);

  static Color disabled = Color.fromARGB(255, 200, 200, 200);

  static Color background = Color.fromARGB(255, 240, 240, 240);
  static Color container = Color.fromARGB(255, 225, 225, 225);

  static Color error = Color.fromARGB(255, 255, 75, 75);
  static Color errorContainer = Color.fromARGB(255, 255, 202, 202);

  static Color onPrimary = Color.fromARGB(255, 255, 255, 255);
  static Color onSecondary = Color.fromARGB(255, 255, 255, 255);
  static Color onTertiary = Color.fromARGB(255, 255, 255, 255);

  static Color onBackground = Color.fromARGB(255, 0, 0, 0);
  static Color onContainer = Color.fromARGB(255, 0, 0, 0);
}
