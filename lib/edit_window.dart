import 'package:flutter/material.dart';
import 'package:simple_todo/color_tag.dart';
import 'package:simple_todo/small_button.dart';
import 'package:simple_todo/util/color_palette.dart';

class EditWindow extends StatefulWidget {
  final TextEditingController textController;
  final Function(int) onSave;
  final int previousImportancyIndex;

  const EditWindow({
    required this.textController,
    required this.previousImportancyIndex,
    required this.onSave,
    super.key,
  });

  @override
  State<EditWindow> createState() => _EditWindowState();
}

class _EditWindowState extends State<EditWindow> {
  bool editing = false;
  late int importancyIndex;

  @override
  void initState() {
    super.initState();
    importancyIndex = widget.previousImportancyIndex;
  }

  void selectImportancy() {}

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
                        widget.onSave(importancyIndex);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                enabled: editing ? true : false,
                controller: widget.textController,
                decoration: InputDecoration(
                  fillColor: ColorPalette.background,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorPalette.primary),
                  ),
                ),
                onChanged: (value) => setState(() {}),
                style: TextStyle(
                  color: ColorPalette.onBackground,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18),
              Text(
                'Importancy',
                style: TextStyle(color: ColorPalette.onBackground),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  SmallButton(
                    onClick:
                        editing
                            ? () {
                              setState(() {
                                importancyIndex = 0;
                              });
                            }
                            : null,
                    selected: importancyIndex == 0,
                    child: Text(
                      'None',
                      style: TextStyle(color: ColorPalette.onBackground),
                    ),
                  ),
                  SizedBox(width: 10),
                  SmallButton(
                    onClick:
                        editing
                            ? () {
                              setState(() {
                                importancyIndex = 1;
                              });
                            }
                            : null,
                    selected: importancyIndex == 1,
                    child: ColorTag(color: ColorPalette.lowImportancy),
                  ),
                  SizedBox(width: 10),
                  SmallButton(
                    onClick:
                        editing
                            ? () {
                              setState(() {
                                importancyIndex = 2;
                              });
                            }
                            : null,
                    selected: importancyIndex == 2,
                    child: ColorTag(color: ColorPalette.midImportancy),
                  ),
                  SizedBox(width: 10),
                  SmallButton(
                    onClick:
                        editing
                            ? () {
                              setState(() {
                                importancyIndex = 3;
                              });
                            }
                            : null,
                    selected: importancyIndex == 3,
                    child: ColorTag(color: ColorPalette.highImportany),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
