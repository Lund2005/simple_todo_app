import 'package:flutter/material.dart';
import 'package:simple_todo/util/color_palette.dart';

class SendingTextField extends StatefulWidget {
  final TextEditingController addingFieldController;
  final Function()? onSend;
  final FocusNode focusNode;

  const SendingTextField({
    super.key,
    required this.onSend,
    required this.addingFieldController,
    required this.focusNode,
  });

  @override
  State<SendingTextField> createState() => _SendingTextFieldState();
}

class _SendingTextFieldState extends State<SendingTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30, left: 12, right: 12, top: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: widget.focusNode,
              controller: widget.addingFieldController,
              decoration: InputDecoration(
                hintText: 'What do you want to do?',
                hintStyle: TextStyle(color: ColorPalette.onBackground),
                contentPadding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 25,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: ColorPalette.tertiary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: ColorPalette.tertiary),
                ),
                fillColor: ColorPalette.background,
              ),
              onChanged: (value) => setState(() {}),
              style: TextStyle(color: ColorPalette.onBackground),
            ),
          ),
          SizedBox(width: 4),
          IconButton.filled(
            iconSize: 25,
            style: IconButton.styleFrom(
              backgroundColor: ColorPalette.primary,
              disabledBackgroundColor: ColorPalette.disabled,
            ),
            padding: EdgeInsets.all(12),
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: ColorPalette.onPrimary,
            ),
            onPressed:
                widget.addingFieldController.text.isNotEmpty
                    ? widget.onSend
                    : null,
          ),
        ],
      ),
    );
  }
}
