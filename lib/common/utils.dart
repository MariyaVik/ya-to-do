import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entities/task.dart';
import '../mobx/state.dart';

double normalizationDouble(
    double oldMin, double oldMax, double newMin, double newMax, double number) {
  double oldRange = oldMax - oldMin;
  double newRange = newMax - newMin;
  return ((number - oldMin) * newRange / oldRange) + newMin;
}

Task getTaskById(BuildContext context, int id) {
  return Provider.of<AppState>(context, listen: false)
      .tasks
      .where((element) => element.id == id)
      .first;
}
