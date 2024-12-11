import 'package:encrypt/encrypt.dart' as encrypt;

class Cryptographer {
  final encrypt.Key _key;
  final encrypt.IV _iv;

  Cryptographer(String secret)
      : _key = encrypt.Key.fromUtf8(_adjustKeyLength(secret)),
        _iv = encrypt.IV.fromLength(16);

  static String _adjustKeyLength(String key) {
    const int keyLength = 32; // AES-256 requires 32 bytes
    if (key.length > keyLength) {
      return key.substring(0, keyLength); // Truncate if too long
    } else if (key.length < keyLength) {
      return key.padRight(keyLength, '*'); // Pad if too short
    }
    return key; // Correct length
  }

  String encryptValue(String value) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final encrypted = encrypter.encrypt(value, iv: _iv);
    return encrypted.base64;
  }

  String decryptValue(String encryptedValue) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final decrypted = encrypter.decrypt64(encryptedValue, iv: _iv);
    return decrypted;
  }
}