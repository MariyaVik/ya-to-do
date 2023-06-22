import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../entities/filter.dart';
import '../entities/importance.dart';
import '../entities/task.dart';
import '../services/client_api.dart';
import '../services/device_info.dart';

part 'state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  final ClientAPI rep;
  _AppState(this.rep) {
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

  @action
  void addTask(Task task) async {
    tasks.add(task);
    log('ДОБАВИЛИ задачу c id ${task.id}');
    revision = await rep.addTask(task, revision);
  }

  @action
  void removeTask(String id) async {
    tasks.remove(tasks.where((element) => element.id == id).first);
    currentId = null;
    currentTask = null;
    log('УДАЛИЛИ задачу c id $id');
    revision = await rep.deleteTask(id, revision);
  }

  @action
  void editTask(
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
    revision = await rep.editTask(task, revision);
  }

  @action
  void toggleDone(String id) async {
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
    revision = await rep.editTask(task, revision);
  }

  @action
  changeLocale(Locale newLocale) {
    currentLocale = newLocale;
  }

  @action
  Future<void> loadAllTodos() async {
    var data = await rep.getTodos();
    revision = data['revision'];
    tasks = ObservableList<Task>.of(
        data['list']?.map<Task>((e) => Task.fromJson(e)).toList());
  }

  @action
  Future<void> getDeviceId() async {
    deviceId = await DeviceInfo.getDeviceId();
    log('ID УСТРОЙСТВА $deviceId');
  }
}
