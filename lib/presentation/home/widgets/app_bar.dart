import 'package:ayat_notifications/utils/enum.dart';
import 'package:flutter/material.dart';

import '../../already_read_ayahs/already_read_ayahs.dart';
import '../../general/logo.dart';
import '../main_service.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AyatiLogo(
        size: 40,
        type: AyatiLogoType.transparent,
      ),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      actions: const <Widget>[
        SizedBox(
          width: 140,
          height: 40,
          child: MainServiceSection(),
        ),
        SizedBox(width: 15.0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
