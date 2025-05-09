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
  List<Task> getAllTasks() => _taskBox.getAll();

  Task? getTask(int id) => _taskBox.get(id);

  int insertTask(Task task) => _taskBox.put(task);

  bool deleteTask(int id) => _taskBox.remove(id);

  void setFinished(bool finished, int id) {
    //TODO not working
    _taskBox.get(id)?.isFinished = finished;
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
