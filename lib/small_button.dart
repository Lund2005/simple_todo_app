import 'package:flutter/material.dart';
import 'package:simple_todo/util/color_palette.dart';

class SmallButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onClick;
  final bool selected;

  const SmallButton({
    required this.child,
    required this.onClick,
    this.selected = false,
    super.key,
  });

  @override
  State<SmallButton> createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(0, 28)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.only(left: 14, right: 14)),
        backgroundColor: WidgetStatePropertyAll(
          widget.selected ? ColorPalette.selected : ColorPalette.background,
        ),
      ),
      onPressed: widget.onClick,
      child: widget.child,
    );
  }
}
