import 'package:flutter/material.dart';
import 'package:simple_todo/todo_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variables
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
    setState(() {
      todos.add(Task(name: _controller.text));
    });

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
      body: Column(
        children: [
          //list view of tasks
          Expanded(
            child: ReorderableListView.builder(
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
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 12,
                    ),
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
          ),
          //bottom bar for adding new tasks
          Container(
            padding: EdgeInsets.only(bottom: 18, left: 12, right: 12, top: 14),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'What do you want to do?',
                      contentPadding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 25,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 4),
                IconButton.filled(
                  iconSize: 25,
                  padding: EdgeInsets.all(12),
                  splashColor: scheme.primary,
                  icon: Icon(
                    Icons.arrow_upward_rounded,
                    color: scheme.onPrimary,
                  ),
                  onPressed: createTask,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//task class to hold task data
class Task {
  String id;
  String name;
  bool done;

  Task({required this.name, this.done = false}) : id = UniqueKey().toString();
}
