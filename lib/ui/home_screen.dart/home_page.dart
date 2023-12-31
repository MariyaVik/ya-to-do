import 'dart:math';
import 'dart:developer' as dev;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../common/navigation/router_delegate.dart';
import '../../common/utils.dart';
import '../../entities/filter.dart';
import '../../mobx/state.dart';
import '../common/check_width.dart';
import '../common/my_card.dart';
import 'widgets/alert_dialogs.dart';
import 'widgets/home_header.dart';
import 'widgets/new_task_list_tile.dart';
import 'widgets/sliver_center_text.dart';
import 'widgets/swipe.dart';
import 'widgets/task_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    dev.log('HOME [BUILD]');

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          final bool isHorTablet =
              CurrentScreen.isTablet(context) && constraints.maxWidth > 700;
          final bool isHorPhone =
              CurrentScreen.isMobile(context) && constraints.maxWidth > 700;
          return Observer(builder: (context) {
            final internetStatus =
                Provider.of<AppState>(context).internetStream;
            if (internetStatus.value == ConnectivityResult.none) {
              Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const NoInternetAlert();
                  },
                );
              });
            } else if (Provider.of<AppState>(context).hasLocalChanges &&
                (internetStatus.value == ConnectivityResult.mobile ||
                    internetStatus.value == ConnectivityResult.wifi)) {
              Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const HasInternetAlert();
                  },
                );
              });
            }
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                    pinned: true,
                    floating: false,
                    delegate: Delegate(
                        maxHeight: isHorTablet || isHorPhone ? 80 : 140,
                        minHeight: 56)),
                Observer(builder: (context) {
                  final filterAll =
                      Provider.of<AppState>(context).currentFilter ==
                          Filter.all;
                  final tasks = filterAll
                      ? Provider.of<AppState>(context).tasks
                      : Provider.of<AppState>(context).undoneTasks;
                  bool isLoading = Provider.of<AppState>(context).isLoading;
                  if (isLoading) {
                    return const SliverCenterWidget(
                        child: CircularProgressIndicator());
                  } else if (filterAll && tasks.isEmpty) {
                    return SliverCenterWidget(
                        child: Text(AppLocalizations.of(context).no_tasks));
                  } else if (!filterAll && tasks.isEmpty) {
                    return SliverCenterWidget(
                        child:
                            Text(AppLocalizations.of(context).no_undone_tasks));
                  }

                  return SliverToBoxAdapter(
                    child: MyCard(
                      marginH: isHorTablet ? 120 : 8,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            tasks.length,
                            (index) {
                              String i = tasks[index].id;
                              return MySwipe(id: i, child: TaskListTile(id: i));
                            },
                          )..add(const NewTaskListTile()),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dev.log('GO TO ADDTASK');
          Provider.of<MyRouterDelegate>(context, listen: false).showTask();
        },
        child: const Icon(Icons.add),
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
    double optimShrinkOffset =
        min(normalizeDouble(0, maxExtent - minExtent, 0, 1, shrinkOffset), 1);
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
