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
  Future<void> clear() async {
    await Future.wait([
      Hive.box<Surah>('surahs').clear(),
      Hive.box<Ayah>('ayahs').clear(),
    ]);
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
  Future<void> init({
    required bool clearOn,
  }) async {
    await Hive.initFlutter();

    Hive.registerAdapter(SurahAdapter());
    Hive.registerAdapter(AyahAdapter());
    Hive.registerAdapter(RevelationTypeAdapter());

    await Hive.openBox<Surah>('surahs');
    await Hive.openBox<Ayah>('ayahs');
    if (clearOn) {
      await clear();
      assert(Hive.box<Surah>('surahs').isEmpty);
      assert(Hive.box<Ayah>('ayahs').isEmpty);
    }
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

    return box.isNotEmpty;
  }

  Future<void> saveCurrentAyah(Ayah ayah) async {
    final box = Hive.box<Ayah>('ayahs');

    await box.put('currentAyah', ayah);
  }

  Future<Ayah> currentAyah() async {
    final box = Hive.box<Ayah>('ayahs');
    if (box.get('currentAyah') == null) {
      final firstSurah = Hive.box<Surah>('surahs').values.first;
      final firstAyah = firstSurah.ayahs.first;
      await saveCurrentAyah(firstAyah);
    }

    return box.get('currentAyah')!;
  }

  Ayah nextAyahThan(Ayah currentAyah) {
    final currentAyahNumber = currentAyah.number;
    final surah = _searchForSurahWithAyahNumber(currentAyah);
    final nextAyahNumber = currentAyahNumber + 1;
    final nextAyah = _getAyahFromSurah(surah, nextAyahNumber);
    if (nextAyah != null) {
      return nextAyah;
    } else {
      // this means we are at the end of the surah.
      // so we need to get the next surah and return the first ayah of that surah
      final nextSurah = _getNextSurah(surah);
      return nextSurah.ayahs.first;
    }
  }

  Surah _searchForSurahWithAyahNumber(Ayah ayah) {
    final surahs = Hive.box<Surah>('surahs').values;
    for (final surah in surahs) {
      if (surah.ayahs.contains(ayah)) {
        return surah;
      }
    }

    throw Exception('Surah not found for ayah number ${ayah.number}');
  }

  Ayah? _getAyahFromSurah(
    Surah surah,
    int ayahNumber,
  ) {
    for (final ayah in surah.ayahs) {
      if (ayah.number == ayahNumber) {
        return ayah;
      }
    }

    return null;
  }

  Surah _getNextSurah(Surah surah) {
    final surahs = Hive.box<Surah>('surahs').values;
    final surahsList = surahs.toList();
    final currentSurahIndex = surahsList.indexOf(surah);
    final nextSurahIndex = currentSurahIndex + 1;
    if (nextSurahIndex < surahs.length) {
      return surahsList[nextSurahIndex];
    } else {
      throw Exception('No next surah found');
    }
  }
}
