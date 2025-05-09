import 'package:simple_todo/objectbox.g.dart';
import 'package:simple_todo/util/models.dart';

class ObjectBox {
  late final Store _store;
  late final Box<Task> _taskBox;

  ObjectBox._init(this._store) {
    _taskBox = Box<Task>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();

    return ObjectBox._init(store);
  }

  //tasks
  List<Task> getAllTasks() {
    List<Task> tasks = [];
    for (var task in _taskBox.getAll()) {
      if (!task.isFinished) {
        tasks.add(task);
      }
    }
    return tasks;
  }

  Task? getTask(int id) => _taskBox.get(id);

  int insertTask(Task task) => _taskBox.put(task);

  bool deleteTask(int id) => _taskBox.remove(id);

  void modifyTask(
    int id,
    String name,
    bool finished,
    int importancy,
    int sortIndex,
  ) {
    Task? task = _taskBox.get(id);
    if (task != null) {
      task.name = name;
      task.isFinished = finished;
      task.importancy = importancy;
      task.sortIndex = sortIndex;
      _taskBox.put(task);
    }
  }

  List<Task> getAllFinishedTasks() {
    List<Task> finishedTasks = [];
    for (var task in _taskBox.getAll()) {
      if (task.isFinished) {
        finishedTasks.add(task);
      }
    }
    return finishedTasks;
  }

  void clearFinishedTasks() {
    for (var task in _taskBox.getAll()) {
      if (task.isFinished) {
        _taskBox.remove(task.id);
      }
    }
  }
}
