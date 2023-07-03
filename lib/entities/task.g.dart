// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      text: json['text'] as String,
      deadline: Task._fromJsonDeadline(json['deadline'] as int?),
      importance:
          $enumDecodeNullable(_$ImportanceEnumMap, json['importance']) ??
              Importance.none,
      isDone: json['done'] as bool? ?? false,
      color: json['color'] as String?,
      changedAt: Task._fromJson(json['changed_at'] as int),
      createdAt: Task._fromJson(json['created_at'] as int),
      lastUpdatedBy: json['last_updated_by'] as String,
    );

Map<String, dynamic> _$TaskToJson(Task instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'text': instance.text,
    'importance': _$ImportanceEnumMap[instance.importance]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deadline', Task._toJsonDeadline(instance.deadline));
  val['done'] = instance.isDone;
  writeNotNull('color', instance.color);
  val['created_at'] = Task._toJson(instance.createdAt);
  val['changed_at'] = Task._toJson(instance.changedAt);
  val['last_updated_by'] = instance.lastUpdatedBy;
  return val;
}

const _$ImportanceEnumMap = {
  Importance.none: 'basic',
  Importance.low: 'low',
  Importance.hight: 'important',
};
