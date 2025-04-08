import 'package:flutter/material.dart';
import 'package:simple_todo/creation_popup.dart';
import 'package:simple_todo/todo_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> todos = [
    Task(name: 'Task 1'),
    Task(name: 'Task 2'),
    Task(name: 'Task 3', done: true),
  ];
  final _controller = TextEditingController();

  //checkbox of a task was changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todos[index].done = value!;
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
              todos.insert(0, Task(name: _controller.text));
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

  //reorder task list after user reordered list view tiles
  void reorderList(oldindex, newindex) {
    if (oldindex < newindex) {
      newindex--;
    }
    setState(() {
      var element = todos.removeAt(oldindex);
      todos.insert(newindex, element);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      //App bar for navigation and information on the top
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
      //button for adding new tasks
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [Icon(Icons.add), SizedBox(width: 4), Text('New task')],
        ),
        onPressed: createTask,
        elevation: 4,
      ),
      //body with list view of tasks
      body: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        proxyDecorator: (child, index, animation) {
          return Material(color: Colors.transparent, child: child);
        },
        onReorder: reorderList,
        itemCount: todos.length,
        itemBuilder: (context, index) {
          Task cur = todos[index];
          return Dismissible(
            //Dismissable key, needs to be unique
            key: Key(cur.id),
            direction: DismissDirection.endToStart,
            background: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.errorContainer,
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [scheme.surface, scheme.errorContainer],
                    begin: Alignment.center,
                  ),
                ),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete, color: scheme.error),
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                todos.removeAt(index);
              });
            },
            child: TodoListTile(
              //List tile key (needs to be specific to the index)
              key: ValueKey(cur.id),
              index: index,
              taskName: cur.name,
              taskCompleted: cur.done,
              onChanged: (value) => checkBoxChanged(value, index),
            ),
          );
        },
      ),
    );
  }
}

class Task {
  String id;
  String name;
  bool done;

  Task({required this.name, this.done = false}) : id = UniqueKey().toString();
}
