import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/settings/settings_cubit.dart';
import '../../utils/routing_handler.dart';
import '../general/screen_title.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return BlocProvider<SettingsCubit>(
      create: (context) => SettingsCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<SettingsCubit>();

          final settingsItems = cubit.settingsItems(onPrivacyPolicyTap: () {
            Navigator.of(context).pushNamed(RoutingPaths.privacy);
          });

          return Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimateList(
                  delay: 200.ms,
                  effects: const [
                    FadeEffect(),
                  ],
                  interval: 100.ms,
                  children: <Widget>[
                    const SizedBox(height: kToolbarHeight),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const ScreenViewTitle(
                        text: AppStrings.settings,
                      ),
                    ),
                    const SizedBox(height: height * 2),
                    ...List.generate(
                      settingsItems.length,
                      (index) {
                        final current = settingsItems[index];
                        return ListTile(
                          onTap: current.onTap,
                          title: Text(current.title),
                          trailing: Icon(current.icon),
                        );
                      },
                    ).toList(),
                  ],
                )),
          );
        },
      ),
    );
  }
}
