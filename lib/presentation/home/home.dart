import 'package:ayat_notifications/presentation/home/widgets/dtats_grid.dart';
import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../general/margined_body.dart';
import 'current_ayah_box.dart';
import 'main_service.dart';
import 'title.dart';
import 'widgets/app_bar.dart';
import '../app/widgets/bottom_app_bar.dart';
import 'widgets/logo.dart';
import 'widgets/start_button.dart';
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
    );
  }
}
