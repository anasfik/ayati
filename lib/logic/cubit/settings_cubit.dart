// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/setting_item.dart';
import '../../utils/notifications.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  List<SettingItem> get settingsItems => [
        SettingItem(
          icon: Icons.ac_unit,
          title: "Cancel all notifications",
          onTap: () {
            NotificationController.cancelService();
          },
          successText: "",
          errorText: "",
        ),
        SettingItem(
          icon: Icons.ac_unit,
          title: "Dismiss all notifications",
          onTap: () {
            NotificationController.dismissAllNotification();
          },
          successText: "",
          errorText: "",
        ),
      ];

  SettingsCubit() : super(SettingsInitial());
}
