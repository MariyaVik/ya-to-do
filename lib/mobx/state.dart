import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:ya_to_do/common/theme/theme_dark.dart';

import '../common/theme/theme_light.dart';
import '../entities/filter.dart';
import '../entities/importance.dart';
import '../entities/task.dart';
import '../services/local/local_service.dart';
import '../services/remote/api.dart';
import '../services/device_info.dart';

part 'state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  final Api rep;
  final LocalService db;
  _AppState(this.rep, this.db) {
    getDeviceId();
    loadAllTodos();
  }

  @observable
  ObservableStream<ConnectivityResult> internetStream =
      ObservableStream(Connectivity().onConnectivityChanged);

  late bool hasLocalChanges = false;
  @observable
  Locale currentLocale = const Locale('ru');

  @observable
  ThemeData currentTheme = themeLight;

  @computed
  bool get isDark => currentTheme == themeDark;

  String? deviceId = '';
  int revision = 0;

  @observable
  ObservableList<Task> tasks = ObservableList.of([]);

  @observable
  bool isLoading = true;

  String? currentId;
  Task? currentTask;

  @observable
  Filter currentFilter = Filter.all;

  @computed
  int get doneCount => tasks.where((element) => element.isDone == true).length;

  @computed
  ObservableList<Task> get undoneTasks =>
      ObservableList.of(tasks.where((element) => element.isDone == false));

  @action
  Future<void> addTask(Task task) async {
    tasks.add(task);

    db.addTask(task);
    hasLocalChanges = true;
    try {
      revision = await rep.addTask(task, revision);
      hasLocalChanges = false;
    } catch (e) {
      log('ОШИБКА ДОБАВЛЕНИЯ НА СЕРВЕР $e');
    }
  }

  @action
  Future<void> removeTask(String id) async {
    tasks.remove(tasks.where((element) => element.id == id).first);
    currentId = null;
    currentTask = null;
    db.deleteTask(id);
    hasLocalChanges = true;
    try {
      revision = await rep.deleteTask(id, revision);
      hasLocalChanges = false;
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
              text: newText,
              importance: newImportance,
              deadline: newDeadline,
              changedAt: DateTime.now(),
              lastUpdatedBy: deviceId)
    ]);
    currentId = null;
    currentTask = null;
    Task task = tasks[index];
    db.editTask(task);
    hasLocalChanges = true;
    try {
      revision = await rep.editTask(task, revision);
      hasLocalChanges = false;
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
          tasks[i].copyWith(
              isDone: !tasks[index].isDone,
              changedAt: DateTime.now(),
              lastUpdatedBy: deviceId)
    ]);
    Task task = tasks[index];
    db.editTask(task);
    hasLocalChanges = true;
    try {
      revision = await rep.editTask(task, revision);
      hasLocalChanges = false;
    } catch (e) {
      log('ОШИБКА ИЗМЕНЕНИЯ НА СЕРВЕРЕ $e');
    }
  }

  @action
  changeLocale(Locale newLocale) {
    currentLocale = newLocale;
  }

  @action
  changeTheme({required bool isDark}) {
    if (isDark) {
      currentTheme = themeDark;
    } else {
      currentTheme = themeLight;
    }
  }

  @action
  Future<void> loadAllTodos() async {
    isLoading = true;
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
    isLoading = false;
  }

  @action
  Future<void> exportLocalTodos() async {
    isLoading = true;
    tasks = ObservableList<Task>.of(await db.getAllTasks());
    try {
      var data = await rep.updateData(revision, tasks);
      revision = data['revision'];
      tasks = ObservableList<Task>.of(
          data['list']?.map<Task>((e) => Task.fromJson(e)).toList());
      await db.cleanDb();
      for (var task in tasks) {
        db.addTask(task);
      }
      hasLocalChanges = false;
    } catch (e) {
      log('ОШИБКА ЗАГРУЗКИ С СЕРВЕРА $e');
    }
    isLoading = false;
  }

  @action
  Future<void> getDeviceId() async {
    deviceId = await DeviceInfo.getDeviceId();
    log('ID УСТРОЙСТВА $deviceId');
  }
}
