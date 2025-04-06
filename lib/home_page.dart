import 'package:flutter/material.dart';
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

  //checkboy of a task was changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todos[index][1] = value;
    });
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
