import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:simple_todo/home_page.dart';
import 'package:simple_todo/util/color_palette.dart';
import 'package:simple_todo/util/object_box.dart';

//objectbox dataset
late ObjectBox objectBox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(MyApp());
  });
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
      home: HomePage(objectBox: objectBox),
    );
  }
}
