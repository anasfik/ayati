import 'dart:io';
import 'package:ayat_notifications/data/local/local.dart';
import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:ayat_notifications/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/ayat_fetcher/ayat_fetcher_cubit.dart';
import 'utils/other.dart';
import 'utils/routing_handler.dart';
import 'utils/themes_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.instance.init(clearOn: true);
  AppServiceCubit.init();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AyatFetcherCubit>(
      create: (context) => AyatFetcherCubit(),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) =>
                AppServiceCubit(fetcherCubit: context.read<AyatFetcherCubit>()),
            child: MaterialApp(
              navigatorKey: navigatorKey,
              onGenerateRoute: NotificationController.onGenerateRoute,
              theme: ThemesHandler.light,
              routes: RoutingHandler.all,
              initialRoute: RoutingPaths.initial,
            ),
          );
        },
      ),
    );
  }
}
