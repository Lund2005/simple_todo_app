import 'package:flutter/material.dart';

import 'package:simple_todo/edit_window.dart';
import 'package:simple_todo/listview_subheading.dart';
import 'package:simple_todo/main.dart';
import 'package:simple_todo/sending_textfield.dart';
import 'package:simple_todo/todo_list_tile.dart';
import 'package:simple_todo/util/color_palette.dart';
import 'package:simple_todo/util/models.dart';
import 'package:simple_todo/util/object_box.dart';

class HomePage extends StatefulWidget {
  final ObjectBox objectBox;

  const HomePage({super.key, required this.objectBox});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variables
  late List<Task> todos;
  late List<Task> finished;

  @override
  void initState() {
    super.initState();
    todos = objectBox.getAllTasks();
    finished = objectBox.getAllFinishedTasks();

    todos.sort((a, b) => a.sortIndex.compareTo(b.sortIndex));
    finished.sort((a, b) => a.sortIndex.compareTo(b.sortIndex));
  }

  final _addingFieldController = TextEditingController();
  final _editingFieldController = TextEditingController();

  final FocusNode bottomSheetFocus = FocusNode();

  //checkbox of a task was changed
  void checkBoxChanged(bool? value, int index) {
    if (value!) {
      setState(() {
        Task task = todos[index];
        objectBox.modifyTask(task.id, task.name, true, task.importancy, 0);
        finished.insert(0, task);
        todos.removeAt(index);
      });
    } else {
      setState(() {
        Task task = finished[index];
        objectBox.modifyTask(
          task.id,
          task.name,
          false,
          task.importancy,
          todos.length,
        );
        todos.add(task);
        finished.removeAt(index);
      });
    }

    updateTaskOrder();
  }

  //create new task
  void createTask() {
    setState(() {
      Task newTask = Task(
        name: _addingFieldController.text,
        sortIndex: todos.length,
      );
      todos.add(newTask);
      objectBox.insertTask(newTask);
    });

    _addingFieldController.clear();
  }

  //reorder todos list after user reordered list view tiles
  void reorderTodos(oldindex, newindex) {
    if (oldindex < newindex) {
      newindex--;
    }
    setState(() {
      var element = todos.removeAt(oldindex);
      todos.insert(newindex, element);
    });

    updateTaskOrder();
  }

  //reorder finished tasks
  void reorderFinished(oldindex, newindex) {
    if (oldindex < newindex) {
      newindex--;
    }
    setState(() {
      var element = finished.removeAt(oldindex);
      finished.insert(newindex, element);
    });

    updateTaskOrder();
  }

  void updateTaskOrder() {
    for (int i = 0; i < todos.length; i++) {
      Task task = todos[i];
      objectBox.modifyTask(task.id, task.name, false, task.importancy, i);
    }
    for (int i = 0; i < finished.length; i++) {
      Task task = finished[i];
      objectBox.modifyTask(task.id, task.name, true, task.importancy, i);
    }
  }

  //proxy generator for task animation
  Widget proxyDecoratorGenerator(child, index, animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double rotation = -0.04 * animation.value;
        return Material(
          color: Colors.transparent,
          child: Transform.rotate(angle: rotation, child: child),
        );
      },
      child: child,
    );
  }

  //display task edit window
  void displayEditWindow(int taskIndex) {
    _editingFieldController.text = todos[taskIndex].name;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorPalette.background,
            ),
            padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 10),
            width: MediaQuery.of(context).size.width,
            height: 240,
            child: EditWindow(
              textController: _editingFieldController,
              previousImportancyIndex: todos[taskIndex].importancy,
              onSave: (importancyIndex) {
                setState(() {
                  todos[taskIndex].name = _editingFieldController.text;
                  todos[taskIndex].importancy = importancyIndex;
                });

                Task task = todos[taskIndex];
                objectBox.modifyTask(
                  task.id,
                  task.name,
                  false,
                  importancyIndex,
                  task.sortIndex,
                );

                updateTaskOrder();

                Future.delayed(const Duration(milliseconds: 300), () {
                  _editingFieldController.clear();
                });
              },
            ),
          ),
        );
      },
    ).whenComplete(() {
      bottomSheetFocus.unfocus();
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

            child:
                todos.isEmpty && finished.isEmpty
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/empty_state_blur.png',
                          width: 300,
                          height: 300,
                        ),
                        SizedBox(height: 80),
                      ],
                    )
                    : ListView(
                      children: [
                        //tasks in progress
                        todos.isNotEmpty
                            ? Padding(
                              padding: const EdgeInsets.only(
                                left: 22,
                                right: 22,
                                top: 12,
                              ),
                              child: ListSubheading(text: 'Tasks in progress'),
                            )
                            : SizedBox(height: 0),
                        ReorderableListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          buildDefaultDragHandles: false,
                          proxyDecorator: proxyDecoratorGenerator,
                          onReorder: reorderTodos,
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            Task cur = todos[index];
                            return Dismissible(
                              //Dismissable key, needs to be unique
                              key: Key(cur.identity),
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
                                  Task toRemove = todos.elementAt(index);
                                  todos.remove(toRemove);
                                  objectBox.deleteTask(toRemove.id);
                                });
                              },
                              //Gesture detector for detecting clicks on task tile (edit task)
                              child: GestureDetector(
                                onTap: () {
                                  displayEditWindow(index);
                                },
                                child: TodoListTile(
                                  //List tile key (needs to be specific to the index)
                                  key: ValueKey(cur.identity),
                                  index: index,
                                  taskName: cur.name,
                                  taskCompleted: false,
                                  importancy: cur.importancy,
                                  environmentalContent: todos,
                                  onChanged:
                                      (value) => checkBoxChanged(value, index),
                                ),
                              ),
                            );
                          },
                        ),
                        //finished subheading
                        finished.isNotEmpty
                            ? Padding(
                              padding: const EdgeInsets.only(
                                left: 22,
                                right: 22,
                                top: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListSubheading(text: 'Finished tasks'),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      minimumSize: WidgetStatePropertyAll(
                                        Size(0, 28),
                                      ),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      overlayColor: WidgetStatePropertyAll(
                                        ColorPalette.container,
                                      ),
                                      padding: WidgetStatePropertyAll(
                                        EdgeInsets.only(left: 14, right: 14),
                                      ),
                                    ),
                                    onPressed: () {
                                      Future.delayed(
                                        const Duration(milliseconds: 300),
                                        () {
                                          setState(() {
                                            finished.clear();
                                            objectBox.clearFinishedTasks();
                                          });
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Clear finished tasks',
                                      style: TextStyle(
                                        color: ColorPalette.secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : SizedBox(height: 0),
                        //listview for finished tasks
                        ReorderableListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          buildDefaultDragHandles: false,
                          proxyDecorator: proxyDecoratorGenerator,
                          onReorder: reorderFinished,
                          itemCount: finished.length,
                          itemBuilder: (context, index) {
                            Task cur = finished[index];
                            return Dismissible(
                              //Dismissable key, needs to be unique
                              key: Key(cur.identity),
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
                                  Task toRemove = finished.elementAt(index);
                                  finished.remove(toRemove);
                                  objectBox.deleteTask(toRemove.id);
                                });
                              },
                              child: TodoListTile(
                                //List tile key (needs to be specific to the index)
                                key: ValueKey(cur.identity),
                                index: index,
                                taskName: cur.name,
                                taskCompleted: true,
                                importancy: cur.importancy,
                                environmentalContent: finished,
                                onChanged:
                                    (value) => checkBoxChanged(value, index),
                              ),
                            );
                          },
                        ),
                        //sized box to be able to view all of the tasks
                        SizedBox(height: 128),
                      ],
                    ),
          ),
          //bottom bar for adding new tasks
          SendingTextField(
            onSend: createTask,
            addingFieldController: _addingFieldController,
            focusNode: bottomSheetFocus,
          ),
        ],
      ),
    );
  }
}
