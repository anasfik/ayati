import 'package:hive_flutter/hive_flutter.dart';

import 'base/base.dart';

class LocalDatabase implements LocalDatabaseBase {
  @override
  Future<void> clear() {
    return Hive.box('ayat').clear();
  }

  @override
  Future<void> delete(String key) {
    return Hive.box('ayat').delete(key);
  }

  @override
  Future<void> dispose() {
    return Hive.close();
  }

  @override
  dynamic get(String key) {
    return Hive.box('ayat').get(key);
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('ayat');
  }

  @override
  Future<void> save(String key, value) {
    return Hive.box('ayat').put(key, value);
  }
}
