import 'package:flutter/material.dart';
import 'package:simple_todo/creation_popup.dart';
import 'package:simple_todo/todo_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todos = [
    ["Test task", false],
    ["Test task 2", true],
    ["Test task  3", true],
  ];
  final _controller = TextEditingController();

  //checkbox of a task was changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todos[index][1] = value;
    });
  }

  //create new task
  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return CreationPopup(
          controller: _controller,
          onCancel: () {
            clearCreationPopup();
          },
          onAdd: () {
            setState(() {
              todos.insert(0, [_controller.text, false]);
            });
            clearCreationPopup();
          },
        );
      },
    );
  }

  //add task from task creation page
  void clearCreationPopup() {
    Navigator.of(context).pop();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: TextStyle(
            color: scheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: scheme.primary,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [Icon(Icons.add), SizedBox(width: 4), Text('New task')],
        ),
        onPressed: createTask,
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          var cur = todos[index];
          return TodoListTile(
            taskName: cur[0],
            taskCompleted: cur[1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
