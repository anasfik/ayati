import 'package:flutter/material.dart';

import '../presentation/app/app.dart';
import '../presentation/home/home.dart';
import '../presentation/notification_payload_receiver/notification_payload_receiver.dart';
import '../presentation/privacy/privacy.dart';

abstract class RoutingHandler {
  static final all = <String, Widget Function(BuildContext context)>{
    RoutingPaths.initial: (context) => const AppView(),
    RoutingPaths.privacy: (context) => const PrivacyAndPolicy(),
  };
}

abstract class RoutingPaths {
  static const initial = '/';
  static const notificationPage = '/notification-page';
  static const privacy = '/privacy';
}
