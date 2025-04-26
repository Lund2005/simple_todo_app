import 'package:flutter/material.dart';
import 'package:simple_todo/util/color_palette.dart';

class EditWindow extends StatefulWidget {
  final TextEditingController textController;
  final Function onSave;

  const EditWindow({
    required this.textController,
    required this.onSave,
    super.key,
  });

  @override
  State<EditWindow> createState() => _EditWindowState();
}

class _EditWindowState extends State<EditWindow> {
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //icon buttons bar
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children:
              !editing
                  ? [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          editing = true;
                        });
                      },
                      icon: Icon(Icons.edit),
                      iconSize: 26,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                      iconSize: 26,
                    ),
                  ]
                  : [
                    //SizedBox for button click animation fix
                    SizedBox(width: 0),
                    IconButton(
                      onPressed: () {
                        widget.onSave();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.check),
                      iconSize: 26,
                    ),
                  ],
        ),
        //content
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              TextFormField(
                enabled: editing ? true : false,
                controller: widget.textController,
                decoration: InputDecoration(fillColor: ColorPalette.background),
                onChanged: (value) => setState(() {}),
                style: TextStyle(
                  color: ColorPalette.onBackground,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
