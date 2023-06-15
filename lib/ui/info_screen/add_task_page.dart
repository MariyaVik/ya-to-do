import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/utils.dart';
import '../../entities/importance.dart';
import '../../entities/task.dart';
import '../../mobx/state.dart';
import '../theme/other_styles.dart';
import 'widgets/info_header.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key, this.id});
  final int? id;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  bool hasDeadline = false;
  late TextEditingController textController;

  DateTime? deadLine;
  Importance importance = Importance.none;

  Task? task;

  Future<DateTime?> selectDeadLine(BuildContext context) {
    return showDatePicker(
        context: context,
        locale: const Locale('ru'),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
  }

  @override
  void initState() {
    super.initState();
    log('ADDTASK [INIT]');
    textController = TextEditingController();
    if (widget.id != null) {
      Provider.of<AppState>(context, listen: false).currentId = widget.id;
      Provider.of<AppState>(context, listen: false).currentTask =
          getTaskById(context, widget.id!);
      task = Provider.of<AppState>(context, listen: false).currentTask;

      if (task != null) {
        textController.text = task!.text;
        hasDeadline = task!.deadline != null;
        if (hasDeadline) {
          deadLine = task!.deadline!;
        }
        importance = task!.importance ?? importance;
      }
    } else {
      Provider.of<AppState>(context, listen: false).currentTask = Task(
          id: Provider.of<AppState>(context, listen: false).lastId + 1,
          text: '');
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
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: Delegate(maxHeight: 56, minHeight: 56)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: cardShadow()),
                  child: TextField(
                    controller: textController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: (text) {
                      task!.text = text;
                    },
                    minLines: 3,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Что надо сделать…',
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Text('Важность'),
                DropdownButton<Importance>(
                  value: importance,
                  iconSize: 0.0,
                  items: [
                    for (int i = 0; i < importanceName.length; i++)
                      DropdownMenuItem<Importance>(
                        value: Importance
                            .values[importanceName.indexOf(importanceName[i])],
                        child: Text(
                          importanceName[i],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: i == 2
                                      ? Theme.of(context).colorScheme.error
                                      : null),
                        ),
                      )
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      importance = newValue ?? importance;
                      task!.importance = importance;
                    });
                  },
                  selectedItemBuilder: (context) => importanceName
                      .map((e) => Text(e,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.tertiary)))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Сделать до'),
                        if (hasDeadline)
                          GestureDetector(
                            onTap: () async {
                              deadLine =
                                  await selectDeadLine(context) ?? deadLine;
                              task!.deadline = deadLine;
                              setState(() {});
                            },
                            child: Text(
                              getDateString(deadLine!),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          )
                      ],
                    ),
                    Switch(
                        value: hasDeadline,
                        onChanged: (value) async {
                          hasDeadline = value;
                          if (hasDeadline) {
                            deadLine =
                                await selectDeadLine(context) ?? deadLine;
                            hasDeadline = deadLine != null;
                            task!.deadline = deadLine;
                          } else {
                            task!.deadline = null;
                          }
                          setState(() {});
                        })
                  ],
                ),
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
                  children: const [Icon(Icons.delete), Text('Удалить')],
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
        normalizationDouble(0, maxExtent, 0, 1, shrinkOffset);
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
