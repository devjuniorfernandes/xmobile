import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../storage/secure_storage_service.dart';
import 'api_error.dart';
import 'auth_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(storage),
    LogInterceptor(requestBody: false, responseBody: false),
  ]);

  return dio;
});

ApiError mapDioError(Object error) {
  if (error is DioException) {
    final data = error.response?.data;
    final message = data is Map<String, dynamic>
        ? (data['message'] ??
                  data['error'] ??
                  'Erro ao comunicar com o servidor.')
              .toString()
        : 'Erro ao comunicar com o servidor.';

    Map<String, List<String>>? validationErrors;
    if (error.response?.statusCode == 422 &&
        data is Map<String, dynamic> &&
        data['errors'] is Map<String, dynamic>) {
      final rawErrors = data['errors'] as Map<String, dynamic>;
      validationErrors = rawErrors.map((key, value) {
        if (value is List) {
          return MapEntry(key, value.map((e) => e.toString()).toList());
        }
        return MapEntry(key, [value.toString()]);
      });
    }

    return ApiError(
      message,
      statusCode: error.response?.statusCode,
      errors: validationErrors,
    );
  }
  return ApiError('Ocorreu um erro inesperado.');
}
