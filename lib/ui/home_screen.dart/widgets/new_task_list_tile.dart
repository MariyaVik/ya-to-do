import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/navigation/route_name.dart';

class NewTaskListTile extends StatelessWidget {
  const NewTaskListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(AppNavRouteName.addTask);
      },
      leading: const Icon(Icons.add, color: Colors.transparent),
      title: Text(
        AppLocalizations.of(context).new_task,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.tertiary),
      ),
    );
  }
}
