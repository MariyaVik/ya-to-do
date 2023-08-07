import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ya_to_do/entities/importance.dart';

import '../../entities/task.dart';
import '../../mobx/state.dart';
import 'widgets/select_deadline.dart';
import 'widgets/select_importance.dart';
import 'widgets/task_description_text_field.dart';

class NarrowVersion extends StatelessWidget {
  final Importance importance;
  final Task? task;
  final DateTime? deadline;
  final String? id;
  final bool isTablet;
  const NarrowVersion({
    super.key,
    required this.deadline,
    required this.id,
    required this.importance,
    required this.task,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskDescriptionTextField(task: task),
              const SizedBox(height: 28),
              Text(AppLocalizations.of(context).importance),
              SelectImportance(importance: importance, task: task!),
              SelectDeadline(deadline: deadline, task: task!),
              const SizedBox(height: 32),
              if (isTablet) const Divider(),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isTablet) const Divider(),
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
      ],
    );
  }
}
