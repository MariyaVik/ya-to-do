import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mobx/state.dart';

class MySwipe extends StatefulWidget {
  final Widget child;
  final String id;
  const MySwipe({super.key, required this.child, required this.id});

  @override
  State<MySwipe> createState() => _MySwipeState();
}

class _MySwipeState extends State<MySwipe> {
  double pos = 0;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(widget.id),
      secondaryBackground: Container(
        color: Theme.of(context).colorScheme.error,
        child: Stack(
          children: [
            // чтобы иконка двигалась со свайпом
            Positioned(
              left: (1 - pos) * MediaQuery.of(context).size.width,
              top: 0,
              bottom: 0,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
      background: Container(
        color: Theme.of(context).colorScheme.outline,
        child: Stack(
          children: [
            // чтобы иконка двигалась со свайпом
            Positioned(
              right: (1 - pos) * MediaQuery.of(context).size.width,
              top: 0,
              bottom: 0,
              child: const Icon(Icons.done, color: Colors.white),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.startToEnd:
            Provider.of<AppState>(context, listen: false).toggleDone(widget.id);
            return false;
          case DismissDirection.endToStart:
            Provider.of<AppState>(context, listen: false).removeTask(widget.id);
            return true;
          default:
            return false;
        }
      },
      onUpdate: (details) {
        pos = details.progress;
        setState(() {});
      },
      child: widget.child,
    );
  }
}
