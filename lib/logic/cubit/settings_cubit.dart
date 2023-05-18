// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/setting_item.dart';
import '../../utils/notifications.dart';
import '../../utils/strings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  List<SettingItem> settingsItems({
    required VoidCallback onPrivacyPolicyTap,
  }) {
    return [
      SettingItem(
        icon: Icons.notifications_off_outlined,
        title: AppStrings.cancelAllNotifications,
        onTap: () {
          NotificationController.cancelService();
        },
        successText: AppStrings.cancelAllNotificationsSuccess,
        errorText: AppStrings.cancelAllNotificationsError,
      ),
      SettingItem(
        icon: Icons.notifications_paused,
        title: AppStrings.dismissAllNotifications,
        onTap: () {
          NotificationController.dismissAllNotification();
        },
        successText: AppStrings.dismissAllNotificationsSuccess,
        errorText: AppStrings.dismissAllNotificationsError,
      ),
      SettingItem(
        icon: Icons.pages,
        title: AppStrings.privacyPolicy,
        onTap: onPrivacyPolicyTap,
        successText: null,
        errorText: null,
      ),
    ];
  }

  SettingsCubit() : super(SettingsInitial());
}
