import 'package:ayat_notifications/data/models/quran_response.dart';

import '../../models/surah.dart';

abstract class LocalDatabaseBase {
  Future<void> init();
  Future save(String key, Surah value);
  Future saveSurah(String key, Surah value);
  dynamic get(String key);
  Future<void> delete(String key);
  Future<void> clear();
  Future<void> dispose();
  Future<void> saveQuranResponse(QuranResponse quranResponse);
}