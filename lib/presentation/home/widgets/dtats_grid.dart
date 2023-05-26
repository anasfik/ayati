import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:ayat_notifications/presentation/general/custom_showcase.dart';
import 'package:ayat_notifications/utils/showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/strings.dart';
import 'stat_box.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppServiceCubit>();

    return CustomShowcase(
      showcaseKey: Showcaser.statsSectionKey,
      description: AppStrings.statsSectionDescription,
      title: AppStrings.statsSectionTitle,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.75,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: cubit.statsItems.length,
        itemBuilder: (context, index) {
          final current = cubit.statsItems[index];

          return StatBox(statItem: current);
        },
      ),
    );
  }
}
