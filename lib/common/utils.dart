import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entities/task.dart';
import '../mobx/state.dart';

double normalizeDouble(
    double oldMin, double oldMax, double newMin, double newMax, double number) {
  double oldRange = oldMax - oldMin;
  double newRange = newMax - newMin;
  return ((number - oldMin) * newRange / oldRange) + newMin;
}

// Task getTaskById(BuildContext context, String id) {
//   if (context.mounted) {
//       return Provider.of<AppState>(context, listen: false)
//           .tasks
//           .where((element) => element.id == id)
//           .first;
//     }
//     throw Exception('нет доступа к стэйту');
// }

// совет предыдущего проверяющего, пока не поняла, как удобнее/лучше
extension GetTaskByIdFromContextExtension on BuildContext {
  Task getTaskById(String id) {
    if (mounted) {
      return Provider.of<AppState>(this, listen: false)
          .tasks
          .where((element) => element.id == id)
          .first;
    }
    throw Exception('нет доступа к стэйту');
  }
}
