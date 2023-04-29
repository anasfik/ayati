import 'package:ayat_notifications/data/models/quran_response.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/surah.dart';
import 'base/base.dart';

class LocalDatabase implements LocalDatabaseBase {
  static LocalDatabase get instance => _instance;
  @override
  Future<void> clear() {
    return Hive.box('surahs').clear();
  }

  @override
  Future<void> delete(String key) {
    return Hive.box('surahs').delete(key);
  }

  @override
  Future<void> dispose() {
    return Hive.close();
  }

  @override
  dynamic get(String key) {
    return Hive.box('surahs').get(key);
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    // Hive.registerAdapter<Surah>(adapter);
    await Hive.openBox<Surah>('surahs');
  }

  @override
  Future<void> save(String key, value) {
    return Hive.box('surahs').put(key, value);
  }

  @override
  Future<void> saveQuranResponse(QuranResponse quranResponse) async {
    for (int i = 0; i < quranResponse.data.surahs.length; i++) {
      final currentSurahs = quranResponse.data.surahs[i];
      await saveSurah(currentSurahs.englishName, currentSurahs);
    }
  }

  @override
  Future<void> saveSurah(String key, Surah value) {
    return save(key, value);
  }

  static final _instance = LocalDatabase._();
  LocalDatabase._();
}
