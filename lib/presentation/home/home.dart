import 'package:ayat_notifications/logic/ayat_fetcher/ayat_fetcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_service.dart';
import 'widgets/logo.dart';
import 'widgets/start_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

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
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                SizedBox(height: height * 2),
                Spacer(),
                AppLogo(),
                Spacer(),
                MainServiceSection(),
                SizedBox(height: height * 2),
              ],
            ),
          ),
        );
      },
    );
  }
}
