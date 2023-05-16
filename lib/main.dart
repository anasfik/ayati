import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ayat_notifications/data/local/local.dart';
import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:ayat_notifications/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/ayat_fetcher/ayat_fetcher_cubit.dart';
import 'presentation/notification_payload_receiver/notification_payload_receiver.dart';
import 'utils/routing_handler.dart';
import 'utils/themes_handler.dart';

final ayatFetcherCubit = AyatFetcherCubit();
final appCubit = AppServiceCubit(fetcherCubit: ayatFetcherCubit);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalDatabase.instance.init(clearOn: false);

  AppServiceCubit.init();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AyatFetcherCubit>.value(
          value: ayatFetcherCubit,
        ),
        BlocProvider<AppServiceCubit>.value(
          value: appCubit,
        ),
      ],
      child: MaterialApp(
        // The navigator key is necessary to allow to navigate through static methods
        navigatorKey: MainApp.navigatorKey,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/notification-page':
              return MaterialPageRoute(
                builder: (context) {
                  final ReceivedAction receivedAction =
                      settings.arguments as ReceivedAction;

                  return NotificationPayloadReceiver(
                    receivedAction: receivedAction,
                    appCubit: appCubit,
                  );
                },
              );

            default:
              assert(false, 'Page ${settings.name} not found');
              return null;
          }
        },
        theme: ThemesHandler.light,
        routes: RoutingHandler.all,
        initialRoute: RoutingHandler.initial,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
