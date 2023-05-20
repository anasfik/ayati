import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:ayat_notifications/logic/ayat_fetcher/ayat_fetcher_cubit.dart';
import 'package:ayat_notifications/presentation/home/widgets/dtats_grid.dart';
import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../general/margined_body.dart';
import 'widgets/bottom_app_bar.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AyatFetcherCubit, AyatFetcherState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const HomeBottomAppBar(),
          body: BlocBuilder<AppServiceCubit, AppServiceState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: state.selectedBottomBarItem!.widget,
              );
            },
          ),
        );
      },
    );
  }
}
