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

  late final _$currentLocaleAtom =
      Atom(name: '_AppState.currentLocale', context: context);

  @override
  Locale get currentLocale {
    _$currentLocaleAtom.reportRead();
    return super.currentLocale;
  }

  @override
  set currentLocale(Locale value) {
    _$currentLocaleAtom.reportWrite(value, super.currentLocale, () {
      super.currentLocale = value;
    });
  }

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

  late final _$loadAllTodosAsyncAction =
      AsyncAction('_AppState.loadAllTodos', context: context);

  @override
  Future<void> loadAllTodos() {
    return _$loadAllTodosAsyncAction.run(() => super.loadAllTodos());
  }

  late final _$getDeviceIdAsyncAction =
      AsyncAction('_AppState.getDeviceId', context: context);

  @override
  Future<void> getDeviceId() {
    return _$getDeviceIdAsyncAction.run(() => super.getDeviceId());
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
  void removeTask(String id) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.removeTask');
    try {
      return super.removeTask(id);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editTask(String id,
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
  void toggleDone(String id) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.toggleDone');
    try {
      return super.toggleDone(id);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeLocale(Locale newLocale) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.changeLocale');
    try {
      return super.changeLocale(newLocale);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentLocale: ${currentLocale},
tasks: ${tasks},
currentFilter: ${currentFilter},
doneCount: ${doneCount},
undoneTasks: ${undoneTasks}
    ''';
  }
}
