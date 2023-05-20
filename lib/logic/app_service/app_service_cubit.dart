import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ayat_notifications/data/local/local.dart';
import 'package:ayat_notifications/data/models/ayah.dart';
import 'package:ayat_notifications/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../data/models/stat_item.dart';
import '../../utils/notifications.dart';
import '../../utils/strings.dart';
import '../ayat_fetcher/ayat_fetcher_cubit.dart';

part 'app_service_state.dart';

class AppServiceCubit extends Cubit<AppServiceState> {
  final AyatFetcherCubit fetcherCubit;
  StreamSubscription? fetcherCubitSubscription;
  AppServiceCubit({
    required this.fetcherCubit,
  }) : super(
          AppServiceInitial(fetcherState: fetcherCubit.state),
        ) {
    NotificationController.setListeners();
    _listenToFetcherCubit();
  }

  @override
  Future<void> close() async {
    fetcherCubitSubscription!.cancel();
    return super.close();
  }

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
    return NotificationController.createAyahNotification(ayah);
  }

  static Future<bool> init() {
    return NotificationController.init();
  }

  void _listenToFetcherCubit() {
    fetcherCubitSubscription = fetcherCubit.stream.listen((fetcherState) {
      emit(state.copyWith(fetcherState: fetcherState));
    });
  }

  List<StatItem> get statsItems => [
        StatItem(
          title: AppStrings.currentAyah,
          icon: FlutterIslamicIcons.quran,
          valueStream: LocalDatabase.instance.valueStream<String, Ayah>(
            boxName: LocalDatabase.instance.ayatBoxName,
            key: 'currentAyah',
            mapper: (ayah) {
              return ayah.text;
            },
          ),
        ),
        StatItem(
          title: AppStrings.ayahsProgress,
          icon: FlutterIslamicIcons.mosque,
          valueStream: LocalDatabase.instance.valueStream<String, Ayah>(
            boxName: LocalDatabase.instance.ayatBoxName,
            key: 'currentAyah',
            mapper: (ayah) {
              return ayah.number.toString() + ' / ' + "6236";
            },
          ),
        ),
      ];
}
