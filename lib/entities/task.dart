import 'package:json_annotation/json_annotation.dart';

import 'importance.dart';

part 'task.g.dart';

@JsonSerializable(includeIfNull: false)
class Task {
  final String id;
  String text;
  Importance importance;
  @JsonKey(toJson: _toJsonDeadline, fromJson: _fromJsonDeadline)
  DateTime? deadline;
  @JsonKey(name: 'done')
  bool isDone;
  String? color;
  @JsonKey(name: 'created_at', toJson: _toJson, fromJson: _fromJson)
  final DateTime createdAt;
  @JsonKey(name: 'changed_at', toJson: _toJson, fromJson: _fromJson)
  DateTime changedAt;
  @JsonKey(name: 'last_updated_by')
  String lastUpdatedBy;

  static int _toJson(DateTime value) => value.millisecondsSinceEpoch;
  static DateTime _fromJson(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value);

  static int? _toJsonDeadline(DateTime? value) => value?.millisecondsSinceEpoch;
  static DateTime? _fromJsonDeadline(int? value) =>
      value == null ? null : DateTime.fromMillisecondsSinceEpoch(value);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task({
    required this.id,
    required this.text,
    this.deadline,
    this.importance = Importance.none,
    this.isDone = false,
    this.color,
    required this.changedAt,
    required this.createdAt,
    required this.lastUpdatedBy,
  });

  Task copyWith({
    String? id,
    String? text,
    Importance? importance,
    DateTime? deadline,
    bool? isDone,
    DateTime? changedAt,
    String? lastUpdatedBy,
    DateTime? createdAt,
    String? color,
  }) =>
      Task(
        id: id ?? this.id,
        text: text ?? this.text,
        deadline: deadline ?? this.deadline,
        importance: importance ?? this.importance,
        isDone: isDone ?? this.isDone,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
        lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
        color: color ?? this.color,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Task &&
        other.id == id &&
        other.text == text &&
        other.importance == importance &&
        other.deadline == deadline &&
        other.isDone == isDone &&
        other.color == color &&
        other.createdAt == createdAt &&
        other.changedAt == changedAt &&
        other.lastUpdatedBy == lastUpdatedBy;
  }

  @override
  int get hashCode => id.hashCode;
}
