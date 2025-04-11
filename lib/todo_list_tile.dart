import 'package:flutter/material.dart';
import 'package:simple_todo/util/color_palette.dart';

class TodoListTile extends StatelessWidget {
  //variables
  final int index;
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;

  const TodoListTile({
    super.key,
    required this.index,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorPalette.container,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            //Task checkbox
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                checkColor: ColorPalette.onPrimary,
                activeColor: ColorPalette.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: ColorPalette.tertiary),
                ),
              ),
            ),
            //Task name
            Text(
              taskName,
              style: TextStyle(
                color:
                    taskCompleted
                        ? ColorPalette.tertiary
                        : ColorPalette.onContainer,
                decorationColor:
                    taskCompleted
                        ? ColorPalette.tertiary
                        : ColorPalette.onContainer,
                fontSize: 14,
                decoration:
                    taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
              ),
            ),
            SizedBox(),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                //drag handle with icon
                child: ReorderableDragStartListener(
                  index: index,
                  child: Icon(Icons.drag_handle, color: ColorPalette.tertiary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
