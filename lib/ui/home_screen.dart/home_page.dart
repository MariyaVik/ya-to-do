import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ya_to_do/ui/navigation/route_name.dart';

import '../../common/utils.dart';
import '../../entities/filter.dart';
import '../../mobx/state.dart';
import '../theme/other_styles.dart';
import 'widgets/home_header.dart';
import 'widgets/swipe.dart';
import 'widgets/task_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget addTaskListTile(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(AppNavRouteName.addTask);
      },
      leading: const Icon(Icons.add, color: Colors.transparent),
      title: Text(
        AppLocalizations.of(context).new_task,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.tertiary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dev.log('HOME [BUILD]');
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: Delegate(maxHeight: 140, minHeight: 56)),
            Observer(builder: (context) {
              final filterAll =
                  Provider.of<AppState>(context).currentFilter == Filter.all;
              final tasks = filterAll
                  ? Provider.of<AppState>(context).tasks
                  : Provider.of<AppState>(context).undoneTasks;
              return filterAll && tasks.isEmpty
                  ? SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                          child: Text(AppLocalizations.of(context).no_tasks)))
                  : !filterAll && tasks.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                              child: Text(AppLocalizations.of(context)
                                  .no_undone_tasks)))
                      : SliverToBoxAdapter(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: cardShadow()),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                ...List.generate(
                                  tasks.length,
                                  (index) {
                                    String i = tasks[index].id;
                                    return MySwipe(
                                        id: i, child: TaskListTile(id: i));
                                  },
                                ),
                                addTaskListTile(context),
                              ]),
                            ),
                          ),
                        );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            dev.log('GO TO ADDTASK');

            Navigator.of(context).pushNamed(AppNavRouteName.addTask);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  Delegate({required this.maxHeight, required this.minHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double optimShrinkOffset = min(
        normalizationDouble(0, maxExtent - minExtent, 0, 1, shrinkOffset), 1);
    return HomeHeader(optimShrinkOffset: optimShrinkOffset);
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
