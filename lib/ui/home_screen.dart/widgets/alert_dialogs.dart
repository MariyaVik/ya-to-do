import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../mobx/state.dart';

class HasInternetAlert extends StatelessWidget {
  const HasInternetAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).has_interner_title),
      content: Text(AppLocalizations.of(context).has_interner_text),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context).no),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context).yes),
          onPressed: () {
            Provider.of<AppState>(context, listen: false).exportLocalTodos();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class NoInternetAlert extends StatelessWidget {
  const NoInternetAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).no_interner_title),
      content: Text(AppLocalizations.of(context).no_interner_text),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context).ok),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
