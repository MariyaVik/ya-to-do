import 'package:json_annotation/json_annotation.dart';

enum Importance {
  @JsonValue("basic")
  none,
  @JsonValue("low")
  low,
  @JsonValue("important")
  hight,
}
