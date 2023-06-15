import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../entities/filter.dart';
import '../entities/importance.dart';
import '../entities/task.dart';

part 'state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  @observable
  ObservableList<Task> tasks = ObservableList.of([]);
  // ObservableList<Task> tasks = ObservableList.of([
  //   Task(
  //       id: 1,
  //       text: 'Что-то необходимое',
  //       importance: Importance.none,
  //       isDone: true),
  //   Task(
  //       id: 2,
  //       text: 'И ещё',
  //       importance: Importance.low,
  //       deadline: DateTime.now()),
  //   Task(
  //       id: 3,
  //       text:
  //           'А это что-то оооочень длинное вот прям очень и наверное что-то важное ',
  //       importance: Importance.hight),
  // ]);

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
  void addTask(Task task) {
    tasks.add(task);
    log('ДОБАВИЛИ задачу c id ${task.id}');
  }

  @action
  void removeTask(int id) {
    tasks.remove(tasks.where((element) => element.id == id).first);
    currentId = null;
    currentTask = null;
    log('УДАЛИЛИ задачу c id $id');
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
    log('ИЗМЕНИЛИ задачу c id $id');
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
    log('ИЗМЕНИЛИ выполнение задачи c id $id ');
  }
}
