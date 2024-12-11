import 'package:frontend/data/local/interface_local_cache.dart';
import 'package:frontend/data/utils/cryptographer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalCacheAdapter implements CacheInterface {
  static LocalCacheAdapter? _instance;
  static SharedPreferences? _prefs;

  final Cryptographer cryptographer;

  LocalCacheAdapter._(this.cryptographer);

  static Future<LocalCacheAdapter> getInstance(String secret) async {
    _instance ??= LocalCacheAdapter._(Cryptographer(secret));
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  @override
  Future<void> saveString(String key, String value) async {
    final encryptedKey = cryptographer.encryptValue(key);
    final encryptedValue = cryptographer.encryptValue(value);
    await _prefs?.setString(encryptedKey, encryptedValue);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    final encryptedKey = cryptographer.encryptValue(key);
    await _prefs?.setInt(encryptedKey, value);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    final encryptedKey = cryptographer.encryptValue(key);
    await _prefs?.setBool(encryptedKey, value);
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    final encryptedKey = cryptographer.encryptValue(key);
    await _prefs?.setDouble(encryptedKey, value);
  }

  @override
  Future<void> saveStringList(String key, List<String> value) async {
    final encryptedKey = cryptographer.encryptValue(key);
    final encryptedList =
        value.map((item) => cryptographer.encryptValue(item)).toList();
    await _prefs?.setStringList(encryptedKey, encryptedList);
  }

  @override
  String? getString(String key) {
    final encryptedKey = cryptographer.encryptValue(key);
    final encryptedValue = _prefs?.getString(encryptedKey);
    return encryptedValue != null
        ? cryptographer.decryptValue(encryptedValue)
        : null;
  }

  @override
  int? getInt(String key) {
    final encryptedKey = cryptographer.encryptValue(key);
    return _prefs?.getInt(encryptedKey);
  }

  @override
  bool? getBool(String key) {
    final encryptedKey = cryptographer.encryptValue(key);
    return _prefs?.getBool(encryptedKey);
  }

  @override
  double? getDouble(String key) {
    final encryptedKey = cryptographer.encryptValue(key);
    return _prefs?.getDouble(encryptedKey);
  }

  @override
  List<String>? getStringList(String key) {
    final encryptedKey = cryptographer.encryptValue(key);
    final encryptedList = _prefs?.getStringList(encryptedKey);
    return encryptedList?.map((item) => cryptographer.decryptValue(item)).toList();
  }

  @override
  Future<void> remove(String key) async {
    final encryptedKey = cryptographer.encryptValue(key);
    await _prefs?.remove(encryptedKey);
  }

  @override
  Future<void> clear() async {
    await _prefs?.clear();
  }

  @override
  bool containsKey(String key) {
    final encryptedKey = cryptographer.encryptValue(key);
    return _prefs?.containsKey(encryptedKey) ?? false;
  }
}
