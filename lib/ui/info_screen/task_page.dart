import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/utils.dart';
import '../../entities/importance.dart';
import '../../entities/task.dart';
import '../../mobx/state.dart';
import 'widgets/info_header.dart';
import 'widgets/select_deadline.dart';
import 'widgets/select_importance.dart';
import 'widgets/task_description_text_field.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, this.id});
  final String? id;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DateTime? deadLine;
  Importance importance = Importance.none;

  Task? task;

  @override
  void initState() {
    super.initState();
    log('ADDTASK [INIT]');
    if (widget.id != null) {
      Provider.of<AppState>(context, listen: false).currentId = widget.id;
      Provider.of<AppState>(context, listen: false).currentTask =
          context.getTaskById(widget.id!);
      task = Provider.of<AppState>(context, listen: false).currentTask;

      if (task != null) {
        if (task!.deadline != null) {
          deadLine = task!.deadline!;
        }
        importance = task!.importance;
      }
    } else {
      Provider.of<AppState>(context, listen: false).currentTask = Task(
        id: (DateTime.now().microsecondsSinceEpoch).toString(),
        text: '',
        createdAt: DateTime.now(),
        changedAt: DateTime.now(),
        lastUpdatedBy:
            Provider.of<AppState>(context, listen: false).deviceId ?? '',
      );
      task = Provider.of<AppState>(context, listen: false).currentTask;
    }
  }

  @override
  void dispose() {
    log('ADDTASK [DISPOSE]');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('ADDTASK [BUILD]');

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: Delegate(maxHeight: 56, minHeight: 56)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                TaskDescriptionTextField(task: task),
                const SizedBox(height: 28),
                Text(AppLocalizations.of(context).importance),
                SelectImportance(importance: importance, task: task!),
                SelectDeadline(deadline: deadLine, task: task!),
                const SizedBox(height: 32),
              ])),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const Divider(),
              TextButton(
                onPressed: widget.id == null
                    ? null
                    : () {
                        Provider.of<AppState>(context, listen: false)
                            .removeTask(widget.id!);
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
            ])),
          ],
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  Delegate({
    required this.maxHeight,
    required this.minHeight,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double optimShrinkOffset =
        normalizeDouble(0, maxExtent, 0, 1, shrinkOffset);
    return InfoHeader(optimShrinkOffset: optimShrinkOffset);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
