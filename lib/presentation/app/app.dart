import 'package:ayat_notifications/data/models/bottom_bar_item.dart';
import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:ayat_notifications/logic/ayat_fetcher/ayat_fetcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/bottom_app_bar.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AyatFetcherCubit, AyatFetcherState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: const HomeBottomAppBar(),
        body: BlocSelector<AppServiceCubit, AppServiceState, BottomBarItem>(
          selector: (state) => state.selectedBottomBarItem!,
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: state.widget,
            );
          },
        ),
      ),
    );
  }
}
