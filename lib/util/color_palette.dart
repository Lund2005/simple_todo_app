import 'package:flutter/material.dart';

/*
This class implements an easy attempt to store the app's colors in a color
pallette like fashion. It therefore is an easy and beginner-friendly alternative
for flutters build in color system.
*/

class ColorPalette {
  static Color primary = const Color.fromARGB(255, 0, 0, 0);
  static Color secondary = Color.fromARGB(255, 45, 45, 45);
  static Color tertiary = Color.fromARGB(255, 161, 161, 161);

  static Color disabled = Color.fromARGB(255, 200, 200, 200);
  static Color selected = Color.fromARGB(255, 221, 221, 221);

  static Color background = Color.fromARGB(255, 240, 240, 240);
  static Color container = Color.fromARGB(255, 248, 248, 248);

  static Color error = Color.fromARGB(255, 255, 65, 65);
  static Color errorContainer = Color.fromARGB(255, 255, 199, 204);

  static Color onPrimary = Color.fromARGB(255, 255, 255, 255);
  static Color onSecondary = Color.fromARGB(255, 255, 255, 255);
  static Color onTertiary = Color.fromARGB(255, 255, 255, 255);

  static Color onBackground = Color.fromARGB(255, 0, 0, 0);
  static Color onContainer = Color.fromARGB(255, 0, 0, 0);

  static Color lowImportancy = const Color.fromARGB(255, 254, 211, 48);
  static Color midImportancy = const Color.fromARGB(255, 253, 150, 68);
  static Color highImportany = const Color.fromARGB(255, 252, 92, 101);

  static Color colorFromImportancy(int index) {
    switch (index) {
      case 1:
        return lowImportancy;
      case 2:
        return midImportancy;
      case 3:
        return highImportany;
      default:
        return background;
    }
  }

  static Color toGrayscaleDisabled(Color color) {
    final int red = (color.r * 255).round();
    final int green = (color.g * 255).round();
    final int blue = (color.b * 255).round();

    int gray = (0.3 * red + 0.59 * green + 0.11 * blue).round();

    return Color.fromARGB(80, gray, gray, gray);
  }
}
