import 'package:flutter/material.dart';

import '../../../entities/importance.dart';
import '../../theme/extention_check_decoration.dart';

class MyCheckBox extends StatefulWidget {
  final bool value;
  final Importance importance;
  final ValueChanged<bool> onChanged;
  const MyCheckBox(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.importance});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 18,
        width: 18,
        decoration: widget.value
            ? Theme.of(context).extension<CheckDecorations>()!.done
            : widget.importance == Importance.hight
                ? Theme.of(context).extension<CheckDecorations>()!.important
                : Theme.of(context).extension<CheckDecorations>()!.usual,
        child: widget.value
            ? Icon(
                Icons.done,
                color: Theme.of(context).colorScheme.surface,
                size: 18,
              )
            : null,
      ),
    );
  }
}
