import 'dart:async';

import 'package:ayat_notifications/data/models/ayah.dart';
import 'package:ayat_notifications/data/models/quran_response.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

import '../models/surah.dart';
import '../models/type.dart';
import 'base/base.dart';

/// {@template local_database}
/// Manages local database operations for ayahs and surahs
/// {@endtemplate}
class LocalDatabase implements LocalDatabaseBase {
  /// {@macro local_database}
  static LocalDatabase get instance => _instance;

  /// The name of the box that contains the ayahs
  @override
  String get ayatBoxName => 'ayats';

  /// The name of the box that contains the surahs
  @override
  String get surahBoxName => "surahs";

  /// Clears the database box that contains the ayahs and surahs, after calling this expect the database to be empty.
  @override
  Future<void> clear() async {
    await Future.wait([
      Hive.box<Surah>(surahBoxName).clear(),
      Hive.box<Ayah>(ayatBoxName).clear(),
      // Hive.deleteFromDisk(),
    ]);
  }

  /// Deletes value associated with the given [key] from the database box that contains the ayahs and surahs.
  @override
  Future<void> delete(String key) {
    return Hive.box(surahBoxName).delete(key);
  }

  /// Closes and ends the local database service.
  @override
  Future<void> dispose() {
    return Hive.close();
  }

  /// Returns the ayah associated with the given [key] from the database box that contains the ayahs and surahs.
  @override
  dynamic get(String key) {
    final box = Hive.box<Surah>(surahBoxName);

    return box.get(key);
  }

  /// Initializes the local database service.
  @override
  Future<void> init({
    required bool clearOn,
  }) async {
    await Hive.initFlutter();

    Hive.registerAdapter(SurahAdapter());
    Hive.registerAdapter(AyahAdapter());
    Hive.registerAdapter(RevelationTypeAdapter());

    await Hive.openBox<Surah>(surahBoxName);
    await Hive.openBox<Ayah>(ayatBoxName);
    if (clearOn) {
      await clear();
      assert(Hive.box<Surah>(surahBoxName).isEmpty);
      assert(Hive.box<Ayah>(ayatBoxName).isEmpty);
    }
  }

  /// Saves the given [value] associated with the given [key] to the database box that contains surahs.
  @override
  Future<void> save(String key, Surah value) async {
    final box = Hive.box<Surah>(surahBoxName);
    await box.add(value);
  }

  /// Saves a list of surahs to the database box that contains surahs from the given [quranResponse].
  @override
  Future<void> saveQuranResponse(QuranResponse quranResponse) async {
    for (int i = 0; i < quranResponse.data.surahs.length; i++) {
      Surah currentSurah = quranResponse.data.surahs[i];
      List<Ayah> currentSurahAyasReferecesTHeSUrahItSelf =
          currentSurah.ayahs.map((item) {
        return item.copyWith(
          surah: currentSurah,
        );
      }).toList();

      currentSurah = currentSurah.copyWith(
        ayahs: currentSurahAyasReferecesTHeSUrahItSelf,
      );

      saveSurah(currentSurah.englishName, currentSurah);
    }
  }

  /// Saves the given [value] associated with the given [key] to the database.
  @override
  Future<void> saveSurah(String key, Surah value) {
    return save(key, value);
  }

  /// {@macro local_database}
  static final _instance = LocalDatabase._();

  /// {@macro local_database}
  /// {@macro local_database}
  LocalDatabase._();

  /// Weither the surahs are already saved in the database or not.
  bool isSurahsAlreadySaved() {
    final box = Hive.box<Surah>(surahBoxName);

    return box.isNotEmpty;
  }

  /// Saves the given [ayah] to the database box that contains ayahs.
  Future<void> saveCurrentAyah(Ayah ayah) async {
    final box = Hive.box<Ayah>(ayatBoxName);

    await box.put('currentAyah', ayah);
  }

  /// Returns the current ayah from the database box that contains ayahs.
  Ayah currentAyah() {
    final box = Hive.box<Ayah>(ayatBoxName);
    if (box.get('currentAyah') == null) {
      final firstSurah = Hive.box<Surah>(surahBoxName).values.first;
      final firstAyah = firstSurah.ayahs.first;
      saveCurrentAyah(firstAyah);
    }

    return box.get('currentAyah')!;
  }

  /// Takes an [ayah] and returns it's next ayah.
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

  Ayah previousAyahThan(Ayah currentAyah) {
    final currentAyahNumber = currentAyah.number;
    final surah = _searchForSurahWithAyahNumber(currentAyah);
    final previousAyahNumber = currentAyahNumber - 1;
    final previousAyah = _getAyahFromSurah(surah, previousAyahNumber);
    if (previousAyah != null) {
      return previousAyah;
    } else {
      final previousSurah = _getPreviousSurah(surah);
      return previousSurah.ayahs.last;
    }
  }

  /// Returns a [Surah] with the given [ayah] number.
  Surah _searchForSurahWithAyahNumber(Ayah ayah) {
    final surahs = Hive.box<Surah>(surahBoxName).values;
    for (final surah in surahs) {
      if (surah.ayahs.any((element) => element.number == ayah.number)) {
        return surah;
      }
    }

    throw Exception('Surah not found for ayah number ${ayah.number}');
  }

  /// Returns an [Ayah] with the given [ayahNumber] from the given [surah].
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

  /// Returns the next [Surah] after the given [surah].
  Surah _getNextSurah(Surah surah) {
    final surahs = Hive.box<Surah>(surahBoxName).values;
    final surahsList = surahs.toList();
    final currentSurahIndex = surahsList.indexOf(surah);
    final nextSurahIndex = currentSurahIndex + 1;
    if (nextSurahIndex < surahs.length) {
      return surahsList[nextSurahIndex];
    } else {
      throw Exception('No next surah found');
    }
  }

  Surah _getPreviousSurah(Surah surah) {
    final surahs = Hive.box<Surah>(surahBoxName).values;
    final surahsList = surahs.toList();
    final currentSurahIndex = surahsList.indexOf(surah);
    final previousSurahIndex = currentSurahIndex - 1;
    if (previousSurahIndex >= 0) {
      return surahsList[previousSurahIndex];
    } else {
      throw Exception('No previous surah found');
    }
  }

  @override
  List<Ayah> ayahsBeforeCurrentOne() {
    final current = currentAyah();
    final allAyahs = Hive.box<Surah>(surahBoxName)
        .values
        .map((surah) => surah.ayahs)
        .expand((ayahs) => ayahs)
        .toList();

    return allAyahs.where((ayah) => ayah.number <= current.number).toList();
  }

  Stream<T?> valueStream<T, R>({
    required String boxName,
    required String key,
    required T Function(R) mapper,
  }) {
    final controller = StreamController<T?>();

    final listenable = Hive.box<R>(boxName).listenable(keys: [key]);

    void onValueTriggered() {
      final value = Hive.box<R>(boxName).get(key);
      if (value == null) {
        controller.add(null);
      } else {
        controller.add(mapper(value));
      }
    }

    listenable.addListener(onValueTriggered);

    controller.onCancel = () {
      listenable.removeListener(onValueTriggered);
    };

    onValueTriggered();

    return controller.stream;
  }

  Stream<Ayah?> currentAyahStream() {
    return valueStream<Ayah, Ayah>(
      boxName: ayatBoxName,
      key: "currentAyah",
      mapper: (event) {
        return event;
      },
    );
  }

  Ayah nextAyahThanCurrent() {
    final current = currentAyah();
    final nextAyah = nextAyahThan(current);
    saveCurrentAyah(nextAyah);
    return nextAyah;
  }

  Ayah previousAyahThanCurrent() {
    final current = currentAyah();
    final previousAyah = previousAyahThan(current);
    saveCurrentAyah(previousAyah);
    return previousAyah;
  }
}
