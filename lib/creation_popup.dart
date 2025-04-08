import 'package:flutter/material.dart';

class CreationPopup extends StatefulWidget {
  const CreationPopup({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onAdd,
  });

  final TextEditingController controller;
  final VoidCallback onCancel;
  final VoidCallback onAdd;

  @override
  State<CreationPopup> createState() => _CreationPopupState();
}

class _CreationPopupState extends State<CreationPopup> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 120,
        width: 300,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: widget.controller,
              decoration: InputDecoration(hintText: 'The next big thing'),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _enabled = false;
                  } else {
                    _enabled = true;
                  }
                });
              },
            ),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: widget.onCancel,
                  child: Text('Cancel'),
                ),
                SizedBox(width: 6),
                FilledButton(
                  onPressed: _enabled ? widget.onAdd : null,
                  child: Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
