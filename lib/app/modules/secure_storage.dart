import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final storage = new FlutterSecureStorage();
  static Future<void> save(String key, String? data) async =>
      await storage.write(key: key, value: data);
  static Future<void> delete_all() async => await storage.deleteAll();
  static Future<void> delete(String key) async =>
      await storage.delete(key: key);
  static Future<String?> read(String key) async {
    return await storage.read(key: key);
  }
}
