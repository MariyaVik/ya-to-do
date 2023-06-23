import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../entities/filter.dart';
import '../entities/importance.dart';
import '../entities/task.dart';
import '../services/client_api.dart';
import '../services/device_info.dart';
import '../services/isar_service.dart';

part 'state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  final ClientAPI rep;
  final IsarService db;
  _AppState(this.rep, this.db) {
    loadAllTodos();
    getDeviceId();
  }

  @observable
  Locale currentLocale = const Locale('ru');

  String? deviceId = '';
  int revision = 0;

  @observable
  ObservableList<Task> tasks = ObservableList.of([]);

  String? currentId;
  Task? currentTask;

  @observable
  Filter currentFilter = Filter.all;

  @computed
  int get doneCount => tasks.where((element) => element.isDone == true).length;

  @computed
  ObservableList<Task> get undoneTasks =>
      ObservableList.of(tasks.where((element) => element.isDone == false));

  // @observable
  // ObservableStream  tasksDB = ObservableStream(db.listenTasks());

  @action
  Future<void> addTask(Task task) async {
    tasks.add(task);
    log('ДОБАВИЛИ задачу c id ${task.id}');
    db.addTask(task);
    try {
      revision = await rep.addTask(task, revision);
    } catch (e) {
      log('ОШИБКА ДОБАВЛЕНИЯ НА СЕРВЕР $e');
    }
  }

  @action
  Future<void> removeTask(String id) async {
    tasks.remove(tasks.where((element) => element.id == id).first);
    currentId = null;
    currentTask = null;
    log('УДАЛИЛИ задачу c id $id');
    db.deleteTask(id);
    try {
      revision = await rep.deleteTask(id, revision);
    } catch (e) {
      log('ОШИБКА УДАЛЕНИЯ С СЕРВЕРА $e');
    }
  }

  @action
  Future<void> editTask(
    String id, {
    String? newText,
    Importance? newImportance,
    DateTime? newDeadline,
  }) async {
    int index = tasks.indexOf(tasks.where((element) => element.id == id).first);
    tasks = ObservableList.of([
      for (int i = 0; i < tasks.length; i++)
        if (i != index)
          tasks[i]
        else
          tasks[i].copyWith(
              text: newText, importance: newImportance, deadline: newDeadline)
    ]);
    currentId = null;
    currentTask = null;
    log('ИЗМЕНИЛИ задачу c id $id');
    Task task = tasks[index];
    db.editTask(task);
    try {
      revision = await rep.editTask(task, revision);
    } catch (e) {
      log('ОШИБКА ИЗМЕНЕНИЯ НА СЕРВЕРЕ $e');
    }
  }

  @action
  Future<void> toggleDone(String id) async {
    int index = tasks.indexOf(tasks.where((element) => element.id == id).first);
    tasks = ObservableList.of([
      for (int i = 0; i < tasks.length; i++)
        if (i != index)
          tasks[i]
        else
          tasks[i].copyWith(isDone: !tasks[index].isDone)
    ]);
    log('ИЗМЕНИЛИ выполнение задачи c id $id ');
    Task task = tasks[index];
    db.editTask(task);
    try {
      revision = await rep.editTask(task, revision);
    } catch (e) {
      log('ОШИБКА ИЗМЕНЕНИЯ НА СЕРВЕРЕ $e');
    }
  }

  @action
  changeLocale(Locale newLocale) {
    currentLocale = newLocale;
  }

  @action
  Future<void> loadAllTodos() async {
    try {
      var data = await rep.getTodos();
      revision = data['revision'];
      tasks = ObservableList<Task>.of(
          data['list']?.map<Task>((e) => Task.fromJson(e)).toList());
      await db.cleanDb();
      for (var task in tasks) {
        db.addTask(task);
      }
    } catch (e) {
      log('ОШИБКА ЗАГРУЗКИ С СЕРВЕРА $e');
      tasks = ObservableList<Task>.of(await db.getAllTasks());
    }
  }

  @action
  Future<void> getDeviceId() async {
    deviceId = await DeviceInfo.getDeviceId();
    log('ID УСТРОЙСТВА $deviceId');
  }
}
