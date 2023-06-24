import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../entities/task.dart';
import '../../theme/other_styles.dart';

class TaskDescriptionTextField extends StatefulWidget {
  final Task? task;
  const TaskDescriptionTextField({super.key, this.task});

  @override
  State<TaskDescriptionTextField> createState() =>
      _TaskDescriptionTextFieldState();
}

class _TaskDescriptionTextFieldState extends State<TaskDescriptionTextField> {
  late TextEditingController textController;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    if (widget.task != null) {
      textController.text = widget.task!.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), boxShadow: cardShadow()),
      child: TextField(
        controller: textController,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (text) {
          widget.task!.text = text;
        },
        minLines: 3,
        maxLines: null,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).what_do,
        ),
      ),
    );
  }
}
