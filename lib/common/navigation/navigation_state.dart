class NavigationState {
  final bool? _unknown;
  final bool? _settings;
  final bool? _new;

  String? selectedItemId;

  bool get isSettings => _settings == true;

  bool get isAddScreen => selectedItemId == null && _new == true;
  bool get isEditScreen => selectedItemId != null;

  bool get isRoot =>
      _settings == false &&
      _unknown == false &&
      selectedItemId == null &&
      _new == false;

  bool get isUnknown => _unknown == true;

  NavigationState.root()
      : _settings = false,
        _unknown = false,
        selectedItemId = null,
        _new = false;

  NavigationState.settings()
      : _settings = true,
        _unknown = false,
        selectedItemId = null,
        _new = false;

  NavigationState.task(this.selectedItemId)
      : _settings = false,
        _unknown = false,
        _new = false;

  NavigationState.newTask()
      : _settings = false,
        _unknown = false,
        selectedItemId = null,
        _new = true;

  NavigationState.unknown()
      : _unknown = true,
        _settings = false,
        selectedItemId = null,
        _new = false;
}
