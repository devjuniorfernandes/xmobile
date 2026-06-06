import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:convert';

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
    // persist user json locally so we can restore session without calling API
    await _storage.saveUserJson(jsonEncode(response.user.toJson()));
    return response.user;
  }

  Future<void> logout() async {
    try {
      await _service.logout();
    } catch (_) {
      // Ignore network errors to guarantee local state is cleared
    }
    _currentUser = null;
    await _storage.clear();
  }

  Future<AppUser?> restoreUserFromStorage() async {
    final json = await _storage.readUserJson();
    if (json == null || json.isEmpty) return null;
    try {
      return AppUser.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }
}
