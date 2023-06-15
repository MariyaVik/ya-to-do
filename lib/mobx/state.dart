import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../entities/filter.dart';
import '../entities/importance.dart';
import '../entities/task.dart';

part 'state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  @observable
  ObservableList<Task> tasks = ObservableList.of([
    // Task(
    //     id: 1,
    //     text: 'Что-то необходимое',
    //     importance: Importance.none,
    //     isDone: true),
    // Task(
    //     id: 2,
    //     text: 'И ещё',
    //     importance: Importance.low,
    //     deadline: DateTime.now()),
    // Task(
    //     id: 3,
    //     text:
    //         'А это что-то оооочень длинное вот прям очень и наверное что-то важное ',
    //     importance: Importance.hight),
  ]);
  // ObservableList<Task> tasks = ObservableList.of([]);

  int? currentId;
  Task? currentTask;

  @observable
  Filter currentFilter = Filter.all;

  @computed
  int get doneCount => tasks.where((element) => element.isDone == true).length;

  @computed
  ObservableList<Task> get undoneTasks =>
      ObservableList.of(tasks.where((element) => element.isDone == false));

  @computed
  int get lastId => tasks.isEmpty ? 0 : tasks.last.id;

  @action
  void addTask(Task task) => tasks.add(task);

  @action
  void removeTask(int id) {
    tasks.remove(tasks.where((element) => element.id == id).first);
    currentId = null;
    currentTask = null;
    log('УДАЛИЛИ задачу');
  }

  @action
  void editTask(int id,
      {String? newText, Importance? newImportance, DateTime? newDeadline}) {
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
    log('ИЗМЕНИЛИ задачу');
  }

  @action
  void toggleDone(int id) {
    int index = tasks.indexOf(tasks.where((element) => element.id == id).first);
    tasks = ObservableList.of([
      for (int i = 0; i < tasks.length; i++)
        if (i != index)
          tasks[i]
        else
          tasks[i].copyWith(isDone: !tasks[index].isDone)
    ]);
    log('ИЗМЕНИЛИ выполнение');
  }
}
