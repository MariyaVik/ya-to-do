import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../entities/task.dart';
import '../../../mobx/state.dart';

class SelectDeadline extends StatefulWidget {
  DateTime? deadline;
  Task task;
  SelectDeadline({super.key, required this.deadline, required this.task});

  @override
  State<SelectDeadline> createState() => _SelectDeadlineState();
}

class _SelectDeadlineState extends State<SelectDeadline> {
  Future<DateTime?> selectDeadLine(BuildContext context) {
    return showDatePicker(
        context: context,
        locale: Provider.of<AppState>(context, listen: false).currentLocale,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).do_until),
            if (widget.task.deadline != null)
              GestureDetector(
                onTap: () async {
                  widget.deadline =
                      await selectDeadLine(context) ?? widget.deadline;
                  widget.task.deadline = widget.deadline;
                  setState(() {});
                },
                child: Text(
                  DateFormat(
                          'd MMMM yyyy',
                          Provider.of<AppState>(context, listen: false)
                              .currentLocale
                              .languageCode)
                      .format(widget.deadline!),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              )
          ],
        ),
        Switch(
            value: widget.task.deadline != null,
            onChanged: (value) async {
              if (value) {
                widget.deadline =
                    await selectDeadLine(context) ?? widget.deadline;

                widget.task.deadline = widget.deadline;
              } else {
                widget.task.deadline = null;
              }
              setState(() {});
            })
      ],
    );
  }
}
