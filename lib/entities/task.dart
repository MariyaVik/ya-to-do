import 'importance.dart';

class Task {
  final int id;
  String text;
  Importance? importance;
  DateTime? deadline;
  bool isDone;

  Task(
      {required this.id,
      required this.text,
      this.deadline,
      this.importance = Importance.none,
      this.isDone = false});

  Task copyWith(
          {int? id,
          String? text,
          Importance? importance,
          DateTime? deadline,
          bool? isDone}) =>
      Task(
        id: id ?? this.id,
        text: text ?? this.text,
        deadline: deadline ?? this.deadline,
        importance: importance ?? this.importance,
        isDone: isDone ?? this.isDone,
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
        other.isDone == isDone;
  }

  @override
  int get hashCode => id;
}
