// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  Computed<int>? _$doneCountComputed;

  @override
  int get doneCount => (_$doneCountComputed ??=
          Computed<int>(() => super.doneCount, name: '_AppState.doneCount'))
      .value;
  Computed<ObservableList<Task>>? _$undoneTasksComputed;

  @override
  ObservableList<Task> get undoneTasks => (_$undoneTasksComputed ??=
          Computed<ObservableList<Task>>(() => super.undoneTasks,
              name: '_AppState.undoneTasks'))
      .value;
  Computed<int>? _$lastIdComputed;

  @override
  int get lastId => (_$lastIdComputed ??=
          Computed<int>(() => super.lastId, name: '_AppState.lastId'))
      .value;

  late final _$tasksAtom = Atom(name: '_AppState.tasks', context: context);

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$currentFilterAtom =
      Atom(name: '_AppState.currentFilter', context: context);

  @override
  Filter get currentFilter {
    _$currentFilterAtom.reportRead();
    return super.currentFilter;
  }

  @override
  set currentFilter(Filter value) {
    _$currentFilterAtom.reportWrite(value, super.currentFilter, () {
      super.currentFilter = value;
    });
  }

  late final _$_AppStateActionController =
      ActionController(name: '_AppState', context: context);

  @override
  void addTask(Task task) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.addTask');
    try {
      return super.addTask(task);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTask(int id) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.removeTask');
    try {
      return super.removeTask(id);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editTask(int id,
      {String? newText, Importance? newImportance, DateTime? newDeadline}) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.editTask');
    try {
      return super.editTask(id,
          newText: newText,
          newImportance: newImportance,
          newDeadline: newDeadline);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleDone(int id) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.toggleDone');
    try {
      return super.toggleDone(id);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tasks: ${tasks},
currentFilter: ${currentFilter},
doneCount: ${doneCount},
undoneTasks: ${undoneTasks},
lastId: ${lastId}
    ''';
  }
}