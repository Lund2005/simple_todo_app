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

  List<Task> getAllTasks() => _taskBox.getAll();

  Task? getTask(int id) => _taskBox.get(id);

  int insertTask(Task task) => _taskBox.put(task);

  bool deleteTask(int id) => _taskBox.remove(id);
}
