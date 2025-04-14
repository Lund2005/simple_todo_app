import 'package:flutter/material.dart';
import 'package:simple_todo/sending_textfield.dart';
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
  final _addingFieldController = TextEditingController();

  //checkbox of a task was changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todos[index].done = value!;
    });
  }

  //create new task
  void createTask() {
    setState(() {
      todos.add(Task(name: _addingFieldController.text));
    });

    _addingFieldController.clear();
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
                stops: [0.75, 0.9], // 50% transparent, 50% white
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,

            child: ListView(
              children: [
                ReorderableListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
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
                            child: Icon(
                              Icons.delete,
                              color: ColorPalette.error,
                            ),
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
                SizedBox(height: 128),
              ],
            ),
          ),
          //bottom bar for adding new tasks
          SendingTextField(
            onSend: createTask,
            addingFieldController: _addingFieldController,
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
