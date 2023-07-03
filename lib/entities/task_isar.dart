import 'package:isar/isar.dart';

import 'importance.dart';

part 'task_isar.g.dart';

@Collection()
class TaskIsar {
  Id id = Isar.autoIncrement;

  late String taskId;

  String text = '';

  @Enumerated(EnumType.name)
  Importance importance = Importance.none;

  DateTime? deadline;
  bool isDone = false;
  String? color;
  late DateTime createdAt;
  late DateTime changedAt;
  late String lastUpdatedBy;
}
