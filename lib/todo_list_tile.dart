import 'package:flutter/material.dart';

class TodoListTile extends StatelessWidget {
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
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            //Task checkbox
            Checkbox(value: taskCompleted, onChanged: onChanged),
            //Task name
            Text(
              taskName,
              style: TextStyle(
                color: scheme.onSurface,
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
                child: ReorderableDragStartListener(
                  index: index,
                  child: Icon(Icons.drag_handle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
