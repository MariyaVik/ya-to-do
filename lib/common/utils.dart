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

String getMonthName(int num) {
  var month = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря'
  ];
  return month[num - 1];
}

String getDateString(DateTime date) {
  // может добавть возможжномть возвращать null ? ПОДУМАТЬ
  return '${date.day} ${getMonthName(date.month)} ${date.year}';
}

Task getTaskById(BuildContext context, int id) {
  return Provider.of<AppState>(context, listen: false)
      .tasks
      .where((element) => element.id == id)
      .first;
}
