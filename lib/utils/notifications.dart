import 'dart:convert';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ayat_notifications/data/models/ayah.dart';
import 'package:flutter/foundation.dart';

import '../main.dart';

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
        (route) =>
            (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }

  static Future<bool> createAyahNotification(Ayah ayah) async {
    return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 11,
        channelKey: 'basic_channel',
        title: ayah.text,
        body: ayah.number.toString(),
        wakeUpScreen: true,
        notificationLayout: NotificationLayout.BigText,
        actionType: ActionType.KeepOnTop,
        autoDismissible: false,
        category: NotificationCategory.Recommendation,
        displayOnBackground: true,
        displayOnForeground: true,
        locked: true,
        payload: {
          "currentAyah": jsonEncode(ayah.toMap()),
        },
      ),
      actionButtons: <NotificationActionButton>[
        NotificationActionButton(
          key: 'Count',
          label: 'Count',
          enabled: true,
          actionType: ActionType.Default,
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
          defaultColor: const Color(0xFF9D50DD),
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
}
