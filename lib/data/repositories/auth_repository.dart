import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/secure_storage_service.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(authServiceProvider),
    ref.watch(secureStorageProvider),
  );
});

class AuthRepository {
  AuthRepository(this._service, this._storage);

  final AuthService _service;
  final SecureStorageService _storage;
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  Future<bool> hasSession() async {
    final token = await _storage.readToken();
    return token != null && token.isNotEmpty;
  }

  Future<AppUser> login(String email, String password) async {
    final response = await _service.login(email: email, password: password);
    await _storage.saveToken(response.token);
    _currentUser = response.user;
    return response.user;
  }

  Future<void> logout() async {
    _currentUser = null;
    await _storage.clear();
  }
}
