import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ayat_notifications/data/local/local.dart';
import 'package:ayat_notifications/data/models/ayah.dart';
import 'package:ayat_notifications/presentation/settings/settings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../data/models/bottom_bar_item.dart';
import '../../data/models/stat_item.dart';
import '../../presentation/already_read_ayahs/already_read_ayahs.dart';
import '../../presentation/home/home.dart';
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
          AppServiceInitial(
            fetcherState: fetcherCubit.state,
          ),
        ) {
    emit(state.copyWith(selectedBottomBarItem: bottomBarItems.first));

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

    final currentAyah = LocalDatabase.instance.currentAyah();
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
          title: AppStrings.currentSurah,
          icon: FlutterIslamicIcons.quran2,
          valueStream: LocalDatabase.instance.valueStream<String, Ayah>(
            boxName: LocalDatabase.instance.ayatBoxName,
            key: 'currentAyah',
            mapper: (ayah) {
              return "${ayah.surah?.name} - ${ayah.surah?.number}";
            },
          ),
        ),
        StatItem(
          title: AppStrings.ayahsProgress,
          icon: FlutterIslamicIcons.prayer,
          valueStream: LocalDatabase.instance.valueStream<String, Ayah>(
            boxName: LocalDatabase.instance.ayatBoxName,
            key: 'currentAyah',
            mapper: (ayah) {
              return "${ayah.number} / 6236";
            },
          ),
        ),
        StatItem(
          title: AppStrings.hizbProgress,
          icon: FlutterIslamicIcons.hadji,
          valueStream: LocalDatabase.instance.valueStream<String, Ayah>(
            boxName: LocalDatabase.instance.ayatBoxName,
            key: 'currentAyah',
            mapper: (ayah) {
              return "${ayah.hizbQuarter} / 60";
            },
          ),
        ),
      ];

  List<BottomBarItem> get bottomBarItems => [
        const BottomBarItem(
          icon: FlutterRemix.home_4_line,
          selectedIcon: FlutterRemix.home_4_fill,
          widget: HomeView(),
        ),
        const BottomBarItem(
          icon: FlutterRemix.list_check_2,
          selectedIcon: FlutterRemix.list_check_2,
          widget: AlreadyReadedAyahs(),
        ),
        const BottomBarItem(
          icon: FlutterRemix.settings_line,
          selectedIcon: FlutterRemix.settings_fill,
          widget: Settings(),
        ),
      ];

  void changeHomePage(BottomBarItem item) {
    emit(state.copyWith(selectedBottomBarItem: item));
  }
}
