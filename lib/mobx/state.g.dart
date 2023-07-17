// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  Computed<bool>? _$isDarkComputed;

  @override
  bool get isDark => (_$isDarkComputed ??=
          Computed<bool>(() => super.isDark, name: '_AppState.isDark'))
      .value;
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

  late final _$importanceColorAtom =
      Atom(name: '_AppState.importanceColor', context: context);

  @override
  String get importanceColor {
    _$importanceColorAtom.reportRead();
    return super.importanceColor;
  }

  @override
  set importanceColor(String value) {
    _$importanceColorAtom.reportWrite(value, super.importanceColor, () {
      super.importanceColor = value;
    });
  }

  late final _$internetStreamAtom =
      Atom(name: '_AppState.internetStream', context: context);

  @override
  ObservableStream<ConnectivityResult> get internetStream {
    _$internetStreamAtom.reportRead();
    return super.internetStream;
  }

  @override
  set internetStream(ObservableStream<ConnectivityResult> value) {
    _$internetStreamAtom.reportWrite(value, super.internetStream, () {
      super.internetStream = value;
    });
  }

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

  late final _$currentThemeAtom =
      Atom(name: '_AppState.currentTheme', context: context);

  @override
  ThemeData get currentTheme {
    _$currentThemeAtom.reportRead();
    return super.currentTheme;
  }

  @override
  set currentTheme(ThemeData value) {
    _$currentThemeAtom.reportWrite(value, super.currentTheme, () {
      super.currentTheme = value;
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

  late final _$isLoadingAtom =
      Atom(name: '_AppState.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
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

  late final _$listenConfigAsyncAction =
      AsyncAction('_AppState.listenConfig', context: context);

  @override
  Future<void> listenConfig() {
    return _$listenConfigAsyncAction.run(() => super.listenConfig());
  }

  late final _$addTaskAsyncAction =
      AsyncAction('_AppState.addTask', context: context);

  @override
  Future<void> addTask(Task task) {
    return _$addTaskAsyncAction.run(() => super.addTask(task));
  }

  late final _$removeTaskAsyncAction =
      AsyncAction('_AppState.removeTask', context: context);

  @override
  Future<void> removeTask(String id) {
    return _$removeTaskAsyncAction.run(() => super.removeTask(id));
  }

  late final _$editTaskAsyncAction =
      AsyncAction('_AppState.editTask', context: context);

  @override
  Future<void> editTask(String id,
      {String? newText, Importance? newImportance, DateTime? newDeadline}) {
    return _$editTaskAsyncAction.run(() => super.editTask(id,
        newText: newText,
        newImportance: newImportance,
        newDeadline: newDeadline));
  }

  late final _$toggleDoneAsyncAction =
      AsyncAction('_AppState.toggleDone', context: context);

  @override
  Future<void> toggleDone(String id) {
    return _$toggleDoneAsyncAction.run(() => super.toggleDone(id));
  }

  late final _$loadAllTodosAsyncAction =
      AsyncAction('_AppState.loadAllTodos', context: context);

  @override
  Future<void> loadAllTodos() {
    return _$loadAllTodosAsyncAction.run(() => super.loadAllTodos());
  }

  late final _$exportLocalTodosAsyncAction =
      AsyncAction('_AppState.exportLocalTodos', context: context);

  @override
  Future<void> exportLocalTodos() {
    return _$exportLocalTodosAsyncAction.run(() => super.exportLocalTodos());
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
  dynamic changeTheme({required bool isDark}) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.changeTheme');
    try {
      return super.changeTheme(isDark: isDark);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
importanceColor: ${importanceColor},
internetStream: ${internetStream},
currentLocale: ${currentLocale},
currentTheme: ${currentTheme},
tasks: ${tasks},
isLoading: ${isLoading},
currentFilter: ${currentFilter},
isDark: ${isDark},
doneCount: ${doneCount},
undoneTasks: ${undoneTasks}
    ''';
  }
}
