import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService(const FlutterSecureStorage());
});

class SecureStorageService {
  SecureStorageService(this._storage);

  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';
  final FlutterSecureStorage _storage;

  Future<String?> readToken() => _storage.read(key: _tokenKey);
  Future<void> saveToken(String token) =>
      _storage.write(key: _tokenKey, value: token);
  Future<String?> readUserJson() => _storage.read(key: _userKey);
  Future<void> saveUserJson(String json) =>
      _storage.write(key: _userKey, value: json);
  Future<void> clear() => _storage.deleteAll();
}
