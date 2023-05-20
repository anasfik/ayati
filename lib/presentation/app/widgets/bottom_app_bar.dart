import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/colors.dart';

class HomeBottomAppBar extends StatelessWidget {
  const HomeBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppServiceCubit>();

    return BlocBuilder<AppServiceCubit, AppServiceState>(
        builder: (context, state) {
      return SizedBox(
        height: 85,
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  AppColors.green,
                  AppColors.darkGreen,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: cubit.bottomBarItems.map((item) {
                final isSelected = state.selectedBottomBarItem == item;

                return GestureDetector(
                  onTap: () {
                    cubit.changeHomePage(item);
                  },
                  child: Icon(
                    isSelected ? item.selectedIcon : item.icon,
                    color: AppColors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }
}
