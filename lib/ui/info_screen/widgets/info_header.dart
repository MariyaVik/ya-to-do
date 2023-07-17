import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/navigation/router_delegate.dart';
import '../../../mobx/state.dart';
import '../../../common/theme/other_styles.dart';

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
                      log('BACK TO HOME');
                      Provider.of<MyRouterDelegate>(context, listen: false)
                          .goBack();
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
                              content: Text(AppLocalizations.of(context)
                                  .warning_description),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      log('BACK TO ADDTASK');
                                      Provider.of<MyRouterDelegate>(context,
                                              listen: false)
                                          .goBack();
                                    },
                                    child: Text(AppLocalizations.of(context)
                                        .ok
                                        .toUpperCase()))
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
                        log('BACK TO HOME');
                        Provider.of<MyRouterDelegate>(context, listen: false)
                            .goBack();
                      }
                    },
                    child:
                        Text(AppLocalizations.of(context).save.toUpperCase()))
              ],
            )));
  }
}
