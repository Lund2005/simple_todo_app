import 'package:flutter/material.dart';
import 'package:simple_todo/util/color_palette.dart';

class SmallButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onClick;
  final bool checked;

  const SmallButton({
    required this.child,
    required this.onClick,
    this.checked = false,
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
        overlayColor: WidgetStatePropertyAll(ColorPalette.container),
        padding: WidgetStatePropertyAll(EdgeInsets.only(left: 14, right: 14)),
      ),
      onPressed: widget.onClick,
      child: Row(
        children: [
          widget.checked ? Icon(Icons.check) : SizedBox(),
          SizedBox(width: 4),
          widget.child,
        ],
      ),
    );
  }
}
