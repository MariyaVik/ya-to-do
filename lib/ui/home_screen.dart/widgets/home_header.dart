import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../common/navigation/router_delegate.dart';
import '../../../common/utils.dart';
import '../../../entities/filter.dart';
import '../../../mobx/state.dart';
import '../../../common/theme/other_styles.dart';
import '../../common/check_width.dart';

class HomeHeader extends StatelessWidget {
  final double optimShrinkOffset;
  const HomeHeader({super.key, required this.optimShrinkOffset});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isHor = constraints.maxWidth > 700;
      return SizedBox.expand(
          child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: headerShadow(optimShrinkOffset)),
        child: Stack(
          children: [
            Positioned(
              left: normalizeDouble(1, 0, 16, 60, optimShrinkOffset),
              bottom: 0, //normalizeDouble(1, 0, 16, 44, optimShrinkOffset),
              top: 0, // normalizeDouble(1, 0, 16, 44, optimShrinkOffset),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context).title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize:
                            normalizeDouble(1, 0, 20, 32, optimShrinkOffset)),
                  ),
                  if (optimShrinkOffset < 0.5)
                    Opacity(
                        opacity: optimShrinkOffset < 0.5
                            ? 1 - 2 * optimShrinkOffset
                            : 0,
                        child: SizedBox(
                          width:
                              normalizeDouble(1, 0, 0, 40, optimShrinkOffset),
                          child: IconButton(
                              iconSize: normalizeDouble(
                                  1, 0, 0, 24, optimShrinkOffset),
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                Provider.of<MyRouterDelegate>(context,
                                        listen: false)
                                    .showSettings();
                              },
                              icon: const Icon(Icons.settings)),
                        )),
                  if (optimShrinkOffset >= 0.5) const SizedBox(width: 20),
                  Observer(builder: (context) {
                    return Text(
                        Provider.of<AppState>(context).internetStream.value ==
                                ConnectivityResult.none
                            ? 'Offline'
                            : 'Online',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ));
                  }),
                ],
              ),
            ),
            if (isHor)
              Positioned(
                right: 64,
                bottom: 0,
                top: 0,
                child: Observer(builder: (context) {
                  return Row(
                    children: [
                      Text(
                          '${AppLocalizations.of(context).done} — ${Provider.of<AppState>(context).doneCount}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              )),
                    ],
                  );
                }),
              )
            else
              Positioned(
                left: normalizeDouble(1, 0, 16, 60, optimShrinkOffset),
                bottom: normalizeDouble(1, 0, 12, 18, optimShrinkOffset),
                child: Opacity(
                  opacity:
                      optimShrinkOffset < 0.5 ? 1 - 2 * optimShrinkOffset : 0,
                  child: Observer(builder: (context) {
                    return Text(
                        '${AppLocalizations.of(context).done} — ${Provider.of<AppState>(context).doneCount}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ));
                  }),
                ),
              ),
            //иконка для фильтрации
            Positioned(
              right: 8,
              bottom: isHor ? 0 : 6,
              top: isHor ? 0 : null,
              child: Observer(builder: (context) {
                return IconButton(
                  icon: Icon(
                    Provider.of<AppState>(context).currentFilter == Filter.all
                        ? Icons.remove_red_eye
                        : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Provider.of<AppState>(context, listen: false)
                            .currentFilter =
                        Provider.of<AppState>(context, listen: false)
                                    .currentFilter ==
                                Filter.all
                            ? Filter.undone
                            : Filter.all;
                    log('ФИЛЬТР ИЗМЕНЁН НА ${Provider.of<AppState>(context, listen: false).currentFilter.name}');
                  },
                );
              }),
            ),
          ],
        ),
      ));
    });
  }
}
