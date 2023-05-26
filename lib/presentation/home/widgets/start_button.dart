import 'package:ayat_notifications/presentation/general/button.dart';
import 'package:ayat_notifications/utils/showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/app_service/app_service_cubit.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AyatiButton(
      onTap: () {
        context.read<AppServiceCubit>().startService();
        const showcaseDelayDuration = Showcaser.showCaseDelayDuration;

        Future.delayed(showcaseDelayDuration, () {
          Showcaser.startShawCase(context, <GlobalKey>[
            Showcaser.statsSectionKey,
          ]);
        });
      },
      text: 'Start Service',
    );
  }
}
