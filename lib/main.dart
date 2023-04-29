import 'package:ayat_notifications/data/local/local.dart';
import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/ayat_fetcher/ayat_fetcher_cubit.dart';
import 'utils/routing_handler.dart';
import 'utils/themes_handler.dart';

void main() async {
  await LocalDatabase.instance.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AyatFetcherCubit>(
          create: (context) => AyatFetcherCubit(),
          lazy: false,
        ),
        BlocProvider<AppServiceCubit>(
          create: (context) => AppServiceCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemesHandler.light,
        routes: RoutingHandler.all,
        initialRoute: RoutingHandler.initial,
      ),
    );
  }
}
