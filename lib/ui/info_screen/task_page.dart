import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/utils.dart';
import '../../entities/importance.dart';
import '../../entities/task.dart';
import '../../mobx/state.dart';
import '../common/check_width.dart';
import 'narrow_version.dart';
import 'wide_version.dart';
import 'widgets/info_header.dart';

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
            CurrentScreen.isMobile(context)
                ? SliverToBoxAdapter(
                    child: LayoutBuilder(builder: (context, constraints) {
                      double width = constraints.constrainWidth();
                      return width > 500
                          ? WideVersion(
                              deadline: deadLine,
                              id: widget.id,
                              importance: importance,
                              task: task,
                            )
                          : NarrowVersion(
                              deadline: deadLine,
                              id: widget.id,
                              importance: importance,
                              task: task,
                            );
                    }),
                  )
                : SliverToBoxAdapter(
                    child: LayoutBuilder(builder: (context, constraints) {
                      double width = constraints.constrainWidth();
                      return width > 700
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 64),
                              child: WideVersion(
                                deadline: deadLine,
                                id: widget.id,
                                importance: importance,
                                task: task,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 48),
                              child: NarrowVersion(
                                deadline: deadLine,
                                id: widget.id,
                                importance: importance,
                                task: task,
                                isTablet: true,
                              ),
                            );
                    }),
                  ),
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
