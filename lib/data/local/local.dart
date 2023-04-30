import 'package:ayat_notifications/data/models/ayah.dart';
import 'package:ayat_notifications/data/models/quran_response.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

import '../models/surah.dart';
import '../models/type.dart';
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
    final box = Hive.box<Surah>('surahs');

    return box.get(key);
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(SurahAdapter());
    Hive.registerAdapter(AyahAdapter());
    Hive.registerAdapter(RevelationTypeAdapter());

    await Hive.openBox<Surah>('surahs');
  }

  @override
  Future<void> save(String key, Surah value) async {
    final box = Hive.box<Surah>('surahs');
    await box.add(value);
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

  bool isSurahsAlreadySaved() {
    final box = Hive.box<Surah>('surahs');
    assert(
      box.values.length == 114,
      'Surahs are not saved, check your code, found only ${box.values.length} surahs',
    );

    return box.isNotEmpty;
  }
}
