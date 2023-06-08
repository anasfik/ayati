import 'package:ayat_notifications/presentation/home/widgets/dtats_grid.dart';
import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../general/margined_body.dart';
import 'current_ayah_box.dart';
import 'title.dart';
import 'widgets/app_bar.dart';
import 'widgets/todo_box.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Scaffold(
      appBar: const HomeAppBar(),
      body: MarginedBody(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimateList(
              interval: 150.ms,
              effects: const <Effect>[
                FadeEffect(),
                // SlideEffect(
                //   begin: Offset(0, 0.5),
                // ),
              ],
              children: const <Widget>[
                SizedBox(height: height * 2),
                TodoBox(),
                SizedBox(height: height * 2),
                HomeTitle(title: AppStrings.stats),
                SizedBox(height: height),
                StatsGrid(),
                SizedBox(height: height * 2),
                HomeTitle(title: AppStrings.continueReading),
                CurrentAyahBox(),
                SizedBox(height: height * 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
