import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/other_styles.dart';
import '../../../entities/importance.dart';
import '../../../common/theme/extention_check_decoration.dart';
import '../../../mobx/state.dart';

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
      child: Observer(builder: (context) {
        return Container(
          margin: const EdgeInsets.all(8),
          height: 18,
          width: 18,
          decoration: widget.value
              ? Theme.of(context).extension<ExtentionCheckDecoration>()!.done
              : widget.importance == Importance.hight
                  ? Provider.of<AppState>(context).isDark
                      ? checkDecorDark(
                          Provider.of<AppState>(context).importanceColor)
                      : checkDecorLight(
                          Provider.of<AppState>(context).importanceColor)
                  : Theme.of(context)
                      .extension<ExtentionCheckDecoration>()!
                      .usual,
          child: widget.value
              ? Icon(
                  Icons.done,
                  color: Theme.of(context).colorScheme.surface,
                  size: 18,
                )
              : null,
        );
      }),
    );
  }
}
