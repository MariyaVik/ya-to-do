import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ya_to_do/common/utils.dart';

import '../../../entities/importance.dart';
import '../../../entities/task.dart';
import '../../../mobx/state.dart';

class SelectImportance extends StatefulWidget {
  Importance importance;
  Task task;
  SelectImportance({super.key, required this.importance, required this.task});

  @override
  State<SelectImportance> createState() => _SelectImportanceState();
}

class _SelectImportanceState extends State<SelectImportance> {
  @override
  Widget build(BuildContext context) {
    List<String> importanceName = [
      AppLocalizations.of(context).importance_no,
      AppLocalizations.of(context).importance_low,
      '!! ${AppLocalizations.of(context).importance_high}'
    ];

    return DropdownButton<Importance>(
      value: widget.importance,
      iconSize: 0.0,
      isExpanded: true,
      items: [
        for (int i = 0; i < importanceName.length; i++)
          DropdownMenuItem<Importance>(
            value: Importance.values[importanceName.indexOf(importanceName[i])],
            child: Observer(builder: (context) {
              final impColor = Provider.of<AppState>(context).importanceColor;
              final color = impColor == ''
                  ? Theme.of(context).colorScheme.error
                  : impColor.toColor();
              return Text(
                importanceName[i],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: i == 2 ? color : null),
              );
            }),
          )
      ],
      onChanged: (newValue) {
        setState(() {
          widget.importance = newValue ?? widget.importance;
          widget.task.importance = widget.importance;
        });
      },
      selectedItemBuilder: (context) => importanceName
          .map((e) => Text(e,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.tertiary)))
          .toList(),
    );
  }
}
