import 'package:flutter/material.dart';
import 'package:simple_todo/home_page.dart';
import 'package:simple_todo/util/color_palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorPalette.secondary,
          selectionColor: ColorPalette.container,
          selectionHandleColor: ColorPalette.secondary,
        ),
      ),
      home: HomePage(),
    );
  }
}
