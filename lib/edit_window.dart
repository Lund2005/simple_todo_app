import 'package:flutter/material.dart';

class EditWindow extends StatefulWidget {
  final String taskName;

  const EditWindow({required this.taskName, super.key});

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
                        //TODO save changes and close modal bottom sheet
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.check),
                      iconSize: 26,
                    ),
                  ],
        ),
        //content
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
          child: Column(children: []),
        ),
      ],
    );
  }
}
