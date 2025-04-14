import 'package:flutter/material.dart';
import 'package:simple_todo/util/color_palette.dart';

class ListSubheading extends StatelessWidget {
  final String text;

  const ListSubheading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22, top: 12),
      child: Text(
        text,
        style: TextStyle(
          color: ColorPalette.onBackground,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
