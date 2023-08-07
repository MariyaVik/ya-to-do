import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ya_to_do/entities/importance.dart';

import '../../../common/navigation/router_delegate.dart';
import '../../../common/utils.dart';
import '../../../mobx/state.dart';
import 'check_box_custom.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({super.key, required this.id});

  final String id;
  // final configRepository = ServiceLocator.configRepository;
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<AppState>(context).tasks;
    int index = tasks.indexOf(context.getTaskById(id));

    return ListTile(
      onTap: () {
        Provider.of<AppState>(context, listen: false).toggleDone(id);
      },
      leading: MyCheckBox(
        value: tasks[index].isDone,
        onChanged: (val) {
          Provider.of<AppState>(context, listen: false).toggleDone(id);
        },
        importance: tasks[index].importance,
      ),
      trailing: IconButton(
          onPressed: () {
            log('GO TO EDITTASK id ${tasks[index].id}');
            Provider.of<MyRouterDelegate>(context, listen: false)
                .showTask(tasks[index].id);
          },
          icon: Icon(
            Icons.info_outline,
            color: Theme.of(context).colorScheme.tertiary,
          )),
      title: Observer(builder: (context) {
        final impColor = Provider.of<AppState>(context).importanceColor;

        return RichText(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              if (tasks[index].importance == Importance.hight)
                TextSpan(
                  text: '!! ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: impColor == ''
                          ? Theme.of(context).colorScheme.error
                          : impColor.toColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              if (tasks[index].importance == Importance.low)
                const WidgetSpan(
                  child: Icon(
                    Icons.arrow_downward,
                    size: 20,
                  ),
                ),
              // TextSpan(
              //   text: String.fromCharCodes(Runes('\u{1F853} ')),
              //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //       color: Theme.of(context).colorScheme.shadow,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18),
              // ),
              TextSpan(
                  text: tasks[index].text,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      decoration: tasks[index].isDone
                          ? TextDecoration.lineThrough
                          : null,
                      color: tasks[index].isDone
                          ? Theme.of(context).colorScheme.tertiary
                          : null)),
            ],
          ),
        );
      }),
      subtitle: tasks[index].deadline == null
          ? null
          : Text(
              DateFormat(
                      'd MMMM yyyy',
                      Provider.of<AppState>(context, listen: false)
                          .currentLocale
                          .languageCode)
                  .format(tasks[index].deadline!),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  )),
    );
  }
}
