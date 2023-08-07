import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ya_to_do/entities/importance.dart';

import '../../entities/task.dart';
import '../../mobx/state.dart';
import '../common/check_width.dart';
import 'widgets/select_deadline.dart';
import 'widgets/select_importance.dart';
import 'widgets/task_description_text_field.dart';

class WideVersion extends StatelessWidget {
  final Importance importance;
  final Task? task;
  final DateTime? deadline;
  final String? id;
  const WideVersion({
    super.key,
    required this.deadline,
    required this.id,
    required this.importance,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CurrentScreen.isTablet(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Hero(
                tag: task?.id ?? 'new',
                child: TaskDescriptionTextField(task: task)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).importance),
                SelectImportance(importance: importance, task: task!),
                SelectDeadline(deadline: deadline, task: task!),
                const SizedBox(height: 32),
                const Divider(),
                TextButton(
                  onPressed: id == null
                      ? null
                      : () {
                          Provider.of<AppState>(context, listen: false)
                              .removeTask(id!);
                          log('BACK TO HOME');
                          Navigator.of(context).pop();
                        },
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error),
                  child: Row(
                    children: [
                      const Icon(Icons.delete),
                      Text(AppLocalizations.of(context).delete)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
