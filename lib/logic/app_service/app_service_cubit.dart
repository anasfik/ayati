import 'dart:convert';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ayat_notifications/data/local/local.dart';
import 'package:ayat_notifications/data/models/ayah.dart';
import 'package:ayat_notifications/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'app_service_state.dart';

class AppServiceCubit extends Cubit<AppServiceState> {
  AppServiceCubit() : super(AppServiceInitial());

  void startService() async {
    final isNotificationAllowed =
        await AwesomeNotifications().isNotificationAllowed();

    if (!isNotificationAllowed) {
      final doesUserGrantedPermission =
          await AwesomeNotifications().requestPermissionToSendNotifications();
      if (!doesUserGrantedPermission) {
        return;
      }
    }

    final currentAyah = await LocalDatabase.instance.currentAyah();
    await createAyahNotification(currentAyah);
  }

  Future<bool> createAyahNotification(Ayah ayah) {
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
      actionButtons: [
        NotificationActionButton(
          key: 'Count',
          label: 'Count',
          enabled: true,
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  Future<bool> createNextAyahNotification(Ayah currentAyah) async {
    final nextAyah = LocalDatabase.instance.nextAyahThan(currentAyah);
    await LocalDatabase.instance.saveCurrentAyah(nextAyah);

    return createAyahNotification(nextAyah);
  }

  static init() {
    AwesomeNotifications().initialize(
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
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
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
}
