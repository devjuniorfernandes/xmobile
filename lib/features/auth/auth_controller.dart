import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../shared/metadata_controller.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthState {
  const AuthState({required this.status, this.user, this.errorMessage});

  const AuthState.checking() : this(status: AuthStatus.checking);
  const AuthState.authenticated(AppUser? user)
    : this(status: AuthStatus.authenticated, user: user);
  const AuthState.unauthenticated({String? error})
    : this(status: AuthStatus.unauthenticated, errorMessage: error);

  final AuthStatus status;
  final AppUser? user;
  final String? errorMessage;
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  late final AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.watch(authRepositoryProvider);
    _restoreSession();
    return const AuthState.checking();
  }

  Future<void> _restoreSession() async {
    final hasSession = await _repository.hasSession();
    if (!hasSession) {
      state = const AuthState.unauthenticated();
      return;
    }

    final user = _repository.currentUser ?? await _repository.restoreUserFromStorage();

    if (user != null) {
      state = AuthState.authenticated(user);
      ref.read(metadataControllerProvider.notifier).bootstrap();
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.checking();
    try {
      final user = await _repository.login(email, password);
      state = AuthState.authenticated(user);
      ref.read(metadataControllerProvider.notifier).bootstrap();
    } catch (error) {
      state = AuthState.unauthenticated(error: error.toString());
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    ref.read(metadataControllerProvider.notifier).clear();
    state = const AuthState.unauthenticated();
  }
}
