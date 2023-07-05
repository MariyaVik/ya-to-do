import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../entities/task.dart';
import '../../entities/task_isar.dart';
import 'local_service.dart';

class IsarService implements LocalService {
  late Future<Isar> db;

  IsarService._() {
    db = openDB();
  }
  static final instance = IsarService._();

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [TaskIsarSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<List<Task>> getAllTasks() async {
    final isar = await db;
    final items = await isar.taskIsars.where().findAll();
    log('ЗАГРУЗИЛИ все задачи из БД');
    return items
        .map((e) => Task(
              id: e.taskId,
              text: e.text,
              changedAt: e.changedAt,
              createdAt: e.createdAt,
              lastUpdatedBy: e.lastUpdatedBy,
              color: e.color,
              deadline: e.deadline,
              importance: e.importance,
              isDone: e.isDone,
            ))
        .toList();
  }

  @override
  Future<List<Task>> getUndoneTasks() async {
    final isar = await db;
    final items = await isar.taskIsars.filter().isDoneEqualTo(true).findAll();
    return items
        .map((e) => Task(
              id: e.taskId,
              text: e.text,
              changedAt: e.changedAt,
              createdAt: e.createdAt,
              lastUpdatedBy: e.lastUpdatedBy,
              color: e.color,
              deadline: e.deadline,
              importance: e.importance,
              isDone: e.isDone,
            ))
        .toList();
  }

  @override
  Future<void> addTask(Task newTask) async {
    final isar = await db;
    final task = TaskIsar()
      ..taskId = newTask.id
      ..text = newTask.text
      ..importance = newTask.importance
      ..deadline = newTask.deadline
      ..isDone = newTask.isDone
      ..color = newTask.color
      ..createdAt = newTask.createdAt
      ..changedAt = newTask.changedAt
      ..lastUpdatedBy = newTask.lastUpdatedBy;
    isar.writeTxnSync(() => isar.taskIsars.putSync(task));
    log('ДОБАВИЛИ задачу в БД');
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.taskIsars.filter().taskIdEqualTo(taskId).deleteAll();
      log('УДАЛИЛИ задачу из БД');
    });
  }

  @override
  Future<void> editTask(Task task) async {
    final isar = await db;
    final isarId =
        isar.taskIsars.filter().taskIdEqualTo(task.id).findFirstSync()!.id;
    await isar.writeTxn(() async {
      await isar.taskIsars.put(TaskIsar()
        ..id = isarId
        ..taskId = task.id
        ..text = task.text
        ..importance = task.importance
        ..deadline = task.deadline
        ..isDone = task.isDone
        ..color = task.color
        ..createdAt = task.createdAt
        ..changedAt = task.changedAt
        ..lastUpdatedBy = task.lastUpdatedBy);
      log('ИЗМЕНИЛИ задачу в БД');
    });
  }

  @override
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
