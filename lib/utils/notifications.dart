import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ayat_notifications/data/models/ayah.dart';
import 'package:ayat_notifications/presentation/notification_payload_receiver/notification_payload_receiver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/local/local.dart';
import '../main.dart';
import 'routing_handler.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    MainApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/notification-page',
      (route) => (route.settings.name != '/notification-page') || route.isFirst,
      arguments: receivedAction,
    );
  }

  static Future<bool> createAyahNotification(Ayah ayah) async {
    return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 11,
        channelKey: 'basic_channel',
        title: ayah.text,
        body: ayah.customNotificationText(),
        notificationLayout: NotificationLayout.Default,
        actionType: ActionType.KeepOnTop,
        autoDismissible: false,
        category: NotificationCategory.LocalSharing,
        displayOnBackground: false,
        displayOnForeground: true,
        locked: true,
        payload: {
          "currentAyah": jsonEncode(ayah.toMap()),
        },
        backgroundColor: Colors.green.shade100,
        badge: ayah.numberInSurah,
        fullScreenIntent: false,
      ),
      actionButtons: <NotificationActionButton>[
        NotificationActionButton(
          key: 'mark_as_read',
          label: 'Mark as read',
          enabled: true,
          actionType: ActionType.Default,
          showInCompactView: true,
          color: Colors.green,
        ),
      ],
    );
  }

  static Future<bool> init() {
    return AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.green,
          ledColor: const Color(0xFFFFFFFF),
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        )
      ],

      debug: kDebugMode,
    );
  }

  static Future<void> cancelService() {
    return AwesomeNotifications().cancelAll();
  }

  static Future<void> dismissAllNotification() {
    return AwesomeNotifications().dismissAllNotifications();
  }

  static Future<void> setListeners() {
    return AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Route<dynamic>? onGenerateRoute(settings) {
    switch (settings.name) {
      case RoutingPaths.notificationPage:
        return MaterialPageRoute(
          builder: (context) {
            final ReceivedAction receivedAction =
                settings.arguments as ReceivedAction;

            return NotificationPayloadReceiver(
              receivedAction: receivedAction,
            );
          },
        );

      default:
        assert(false, 'Page ${settings.name} not found');
        return null;
    }
  }

  static Future<bool> createNextAyahNotification(Ayah currentAyah) async {
    final nextAyah = LocalDatabase.instance.nextAyahThan(currentAyah);
    await LocalDatabase.instance.saveCurrentAyah(nextAyah);

    return createAyahNotification(nextAyah);
  }
}
