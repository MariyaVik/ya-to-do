import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mobx/state.dart';
import '../../theme/other_styles.dart';

class InfoHeader extends StatelessWidget {
  final double optimShrinkOffset;
  const InfoHeader({super.key, required this.optimShrinkOffset});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: headerShadow(optimShrinkOffset)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close)),
                TextButton(
                    onPressed: () {
                      final task = Provider.of<AppState>(context, listen: false)
                          .currentTask;
                      final id = Provider.of<AppState>(context, listen: false)
                          .currentId;

                      if (task!.text.trim() == '') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: const Text('Введите описание задачи!'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Понятно'.toUpperCase()))
                              ],
                            );
                          },
                        );
                      } else {
                        if (id != null) {
                          Provider.of<AppState>(context, listen: false)
                              .editTask(id,
                                  newDeadline: task.deadline,
                                  newImportance: task.importance,
                                  newText: task.text);
                        } else {
                          Provider.of<AppState>(context, listen: false)
                              .addTask(task);
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Сохранить'.toUpperCase()))
              ],
            )));
  }
}
