import 'package:flutter/material.dart';
import 'package:simple_todo/todo_list_tile.dart';
import 'package:simple_todo/util/color_palette.dart';

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
    Task(name: 'Task 1'),
    Task(name: 'Task 2'),
    Task(name: 'Task 3'),
    Task(name: 'Task 1'),
    Task(name: 'Task 2'),
    Task(name: 'Task 3', done: true),
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
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //list view of tasks
          ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, ColorPalette.background],
                //set stops as par your requirement
                stops: [0.7, 0.9], // 50% transparent, 50% white
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,

            child: Expanded(
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
                          color: ColorPalette.errorContainer,
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              ColorPalette.background,
                              ColorPalette.errorContainer,
                            ],
                            begin: Alignment.center,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(Icons.delete, color: ColorPalette.error),
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
          ),
          //bottom bar for adding new tasks
          Container(
            padding: EdgeInsets.only(bottom: 22, left: 12, right: 12, top: 14),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'What do you want to do?',
                      hintStyle: TextStyle(color: ColorPalette.tertiary),
                      contentPadding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 25,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: ColorPalette.disabled),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: ColorPalette.disabled),
                      ),
                      fillColor: ColorPalette.background,
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                SizedBox(width: 4),
                IconButton.filled(
                  iconSize: 25,
                  style: IconButton.styleFrom(
                    backgroundColor: ColorPalette.primary,
                    disabledBackgroundColor: ColorPalette.disabled,
                  ),
                  padding: EdgeInsets.all(12),
                  icon: Icon(
                    Icons.arrow_upward_rounded,
                    color: ColorPalette.onPrimary,
                  ),
                  onPressed: _controller.text.isNotEmpty ? createTask : null,
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
