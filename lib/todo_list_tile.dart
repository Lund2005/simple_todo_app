import 'package:flutter/material.dart';
import 'package:simple_todo/color_tag.dart';
import 'package:simple_todo/util/color_palette.dart';

class TodoListTile extends StatefulWidget {
  //variables
  final int index;
  final String taskName;
  final bool taskCompleted;
  final int importancy;
  final Function(bool?)? onChanged;
  final List environmentalContent;

  const TodoListTile({
    super.key,
    required this.index,
    required this.taskName,
    required this.taskCompleted,
    required this.importancy,
    required this.onChanged,
    required this.environmentalContent,
  });

  @override
  State<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorPalette.container,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            //BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 15),
          ],
        ),
        child: Row(
          children: [
            //Task checkbox
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: widget.taskCompleted,
                onChanged: widget.onChanged,
                checkColor: ColorPalette.onPrimary,
                activeColor: ColorPalette.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: ColorPalette.tertiary),
                ),
              ),
            ),
            //Task name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.importancy != 0
                      ? ColorTag(
                        width: 32,
                        height: 8,
                        color: ColorPalette.colorFromImportancy(
                          widget.importancy,
                        ),
                      )
                      : SizedBox(height: 0),
                  Text(
                    widget.taskName,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color:
                          widget.taskCompleted
                              ? ColorPalette.tertiary
                              : ColorPalette.onContainer,
                      decorationColor:
                          widget.taskCompleted
                              ? ColorPalette.tertiary
                              : ColorPalette.onContainer,
                      fontSize: 14,
                      decoration:
                          widget.taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              //drag handle with icon
              child: ReorderableDragStartListener(
                enabled: widget.environmentalContent.length > 1,
                index: widget.index,
                child: Icon(Icons.drag_handle, color: ColorPalette.tertiary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
