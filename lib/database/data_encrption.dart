import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

class XEncryption {
  static final key = encrypt.Key.fromUtf8('ynqkqzvzdwertpeakwpfdmrsqeflihqy');
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.ctr, padding: null));

  String encryptAES(text) {
    try {
      final encrypted = encrypter.encrypt(text, iv: iv);
      return encrypted.base64;
    } catch (e) {
      return 'Mynull';
    }
  }

  String decryptAES(text) {
    try {
      final encrypted = encrypt.Encrypted.fromBase64(text);
      final decrypted = encrypter.decryptBytes(encrypted, iv: iv);
      final decryptedData = utf8.decode(decrypted);

      return decryptedData;
    } catch (e) {
      return 'Mynull';
    }
  }
}
