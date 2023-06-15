import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../common/utils.dart';
import '../../../entities/filter.dart';
import '../../../mobx/state.dart';
import '../../theme/other_styles.dart';

class HomeHeader extends StatelessWidget {
  final double optimShrinkOffset;
  const HomeHeader({super.key, required this.optimShrinkOffset});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: headerShadow(optimShrinkOffset)),
      child: Stack(
        children: [
          Positioned(
            left: normalizationDouble(1, 0, 16, 60, optimShrinkOffset),
            bottom: normalizationDouble(1, 0, 16, 44, optimShrinkOffset),
            child: Text(
              'Мои дела',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize:
                      normalizationDouble(1, 0, 20, 32, optimShrinkOffset)),
            ),
          ),
          Positioned(
            left: normalizationDouble(1, 0, 16, 60, optimShrinkOffset),
            bottom: normalizationDouble(1, 0, 12, 18, optimShrinkOffset),
            child: Opacity(
              opacity: optimShrinkOffset < 0.5 ? 1 - 2 * optimShrinkOffset : 0,
              child: Observer(builder: (context) {
                return Text(
                    'Выполнено — ${Provider.of<AppState>(context).doneCount}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ));
              }),
            ),
          ),
          //иконка для фильтрации
          Positioned(
            right: 8,
            bottom: 6,
            child: Observer(builder: (context) {
              return IconButton(
                icon: Icon(
                  Provider.of<AppState>(context).currentFilter == Filter.all
                      ? Icons.remove_red_eye
                      : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Provider.of<AppState>(context, listen: false).currentFilter =
                      Provider.of<AppState>(context, listen: false)
                                  .currentFilter ==
                              Filter.all
                          ? Filter.undone
                          : Filter.all;
                },
              );
            }),
          ),
        ],
      ),
    ));
  }
}
