import 'package:flutter/material.dart';

class ColorTag extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const ColorTag({
    this.width = 36,
    this.height = 8,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
