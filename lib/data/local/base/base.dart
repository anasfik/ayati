abstract class LocalDatabaseBase {
  Future<void> init();
  Future save(String key, dynamic value);
  dynamic get(String key);
  Future<void> delete(String key);
  Future<void> clear();
  Future<void> dispose();
}
