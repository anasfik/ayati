import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return const Center(child: CircularProgressIndicator());
        } else if (state.fetcherState.areAyahsSavedForLaterUse) {
          return const StartButton();
        } else if (state.fetcherState.error != null) {
          return const ErrorDuringFetch();
        } else {
          return const LoadAyahsButton();
        }
      },
    );
  }
}
