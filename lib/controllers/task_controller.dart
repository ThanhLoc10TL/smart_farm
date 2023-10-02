import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = [
    Task(status: false, hour: 7, minute: 17, timer: 17),
    Task(status: false, hour: 7, minute: 17, timer: 17),
    Task(status: false, hour: 7, minute: 17, timer: 17),
    Task(status: false, hour: 7, minute: 17, timer: 17),
    Task(status: false, hour: 7, minute: 17, timer: 17),
    Task(status: false, hour: 7, minute: 17, timer: 17),
    Task(status: false, hour: 7, minute: 17, timer: 17),
  ].obs;

  Future<void> initDb(int index) async {
    await DBHelper.initDb(index);
  }

  Future<int> addTask({Task? task}) {
    return DBHelper.insert(task);
  }

  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }

  void updateTask(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
