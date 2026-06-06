import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/api_constants.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(dioProvider));
});

class AuthService {
  AuthService(this._dio);

  final Dio _dio;

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
          'device_name': AppConstants.deviceName,
        },
      );
      return AuthResponse.fromJson(response.data ?? {});
    } catch (error) {
      throw mapDioError(error);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post<dynamic>('/logout');
    } catch (error) {
      throw mapDioError(error);
    }
  }
}
