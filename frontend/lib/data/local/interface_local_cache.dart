abstract class CacheInterface {
  Future<void> saveString(String key, String value);
  Future<void> saveInt(String key, int value);
  Future<void> saveBool(String key, bool value);
  Future<void> saveDouble(String key, double value);
  Future<void> saveStringList(String key, List<String> value);

  String? getString(String key);
  int? getInt(String key);
  bool? getBool(String key);
  double? getDouble(String key);
  List<String>? getStringList(String key);

  Future<void> remove(String key);
  Future<void> clear();
  bool containsKey(String key);
}
