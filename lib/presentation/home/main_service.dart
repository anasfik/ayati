import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/showcase.dart';
import '../../utils/strings.dart';
import '../general/custom_showcase.dart';
import 'error.dart';
import 'load_button.dart';
import 'widgets/start_button.dart';

class MainServiceSection extends StatelessWidget {
  const MainServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppServiceCubit, AppServiceState>(
      builder: (context, state) {
        if (state.fetcherState.isLoadingForAyat) {
          return const Center(
            child: SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          );
        } else if (state.fetcherState.areAyahsSavedForLaterUse) {
          const showcaseDelayDuration = Showcaser.showCaseDelayDuration;

          Future.delayed(showcaseDelayDuration, () {
            Showcaser.startShawCase(context, <GlobalKey>[
              Showcaser.startButtonKey,
            ]);
          });

          return CustomShowcase(
            showcaseKey: Showcaser.startButtonKey,
            description: AppStrings.startServiceDescription,
            title: AppStrings.startServiceTitle,
            child: const SizedBox(
              width: 110,
              height: 35,
              child: StartButton(),
            ),
          );
        } else if (state.fetcherState.error != null) {
          return const ErrorDuringFetch();
        } else {
          const showcaseDelayDuration = Showcaser.showCaseDelayDuration;

          Future.delayed(showcaseDelayDuration, () {
            Showcaser.startShawCase(context, <GlobalKey>[
              Showcaser.loadButtonKey,
            ]);
          });

          return CustomShowcase(
            description: AppStrings.loadDataDescription,
            title: AppStrings.loadData,
            showcaseKey: Showcaser.loadButtonKey,
            child: const SizedBox(
              width: 110,
              height: 35,
              child: LoadAyahsButton(),
            ),
          );
        }
      },
    );
  }
}
