import 'package:ayat_notifications/presentation/settings/settings.dart';
import 'package:flutter/material.dart';

import '../../already_read_ayahs/already_read_ayahs.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Settings(),
              ),
            );
          },
          icon: const Icon(Icons.settings),
        ),
        const SizedBox(width: 10.0),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AlreadyReadedAyahs(),
              ),
            );
          },
          icon: const Icon(Icons.notifications),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
