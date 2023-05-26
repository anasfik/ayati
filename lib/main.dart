import 'dart:io';
import 'package:ayat_notifications/data/local/local.dart';
import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:ayat_notifications/utils/notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'logic/ayat_fetcher/ayat_fetcher_cubit.dart';
import 'utils/other.dart';
import 'utils/routing_handler.dart';
import 'utils/themes_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalDatabase.instance.init(clearOn: kDebugMode);
  AppServiceCubit.init();

  HttpOverrides.global = MyHttpOverrides();

  // Animate.defaultDuration = const Duration(milliseconds: 200);
  // Animate.defaultCurve = Curves.easeInOut;
  Animate.restartOnHotReload = true;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AyatFetcherCubit>(
      create: (context) => AyatFetcherCubit(),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) =>
                AppServiceCubit(fetcherCubit: context.read<AyatFetcherCubit>()),
            child: ShowCaseWidget(
              onStart: (index, key) {
                print('onStart: $index, $key');
              },
              onComplete: (index, key) {
                print('onComplete: $index, $key');
              },
              builder: Builder(builder: (context) {
                return MaterialApp(
                  navigatorKey: navigatorKey,
                  onGenerateRoute: NotificationController.onGenerateRoute,
                  theme: ThemesHandler.light,
                  routes: RoutingHandler.all,
                  initialRoute: RoutingPaths.initial,
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
