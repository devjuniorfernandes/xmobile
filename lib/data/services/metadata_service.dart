import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_client.dart';
import '../models/user_model.dart';

final metadataServiceProvider = Provider<MetadataService>((ref) {
  return MetadataService(ref.watch(dioProvider));
});

class MetadataService {
  MetadataService(this._dio);

  final Dio _dio;

  Future<List<NamedEntity>> fetchStatusTarefas() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/metadados/status-tarefas',
      );
      final list = response.data?['data'] as List?;
      return list
              ?.map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
    } catch (e) {
      throw mapDioError(e);
    }
  }

  Future<List<String>> fetchStatusProjetos() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/metadados/status-projetos',
      );
      final list = response.data?['data'] as List?;
      return list
              ?.map((e) => (e['nome'] ?? e['name'] ?? '').toString())
              .toList() ??
          [];
    } catch (e) {
      throw mapDioError(e);
    }
  }

  Future<List<NamedEntity>> fetchPrioridades() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/metadados/prioridades',
      );
      final list = response.data?['data'] as List?;
      return list
              ?.map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
    } catch (e) {
      throw mapDioError(e);
    }
  }

  Future<List<Map<String, dynamic>>> fetchUsuarios({
    String? papel,
    int? departamentoId,
    String? q,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/metadados/usuarios',
        queryParameters: {
          'papel':? papel,
          'departamento_id':? departamentoId,
          'q':? q,
        },
      );
      final list = response.data?['data'] as List?;
      return list?.cast<Map<String, dynamic>>() ?? [];
    } catch (e) {
      throw mapDioError(e);
    }
  }

  Future<List<NamedEntity>> fetchEmpresas({String? q}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/metadados/empresas',
        queryParameters: {'q':? q},
      );
      final list = response.data?['data'] as List?;
      return list
              ?.map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
    } catch (e) {
      throw mapDioError(e);
    }
  }

  Future<List<NamedEntity>> fetchDepartamentos({String? q}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/metadados/departamentos',
        queryParameters: {'q':? q},
      );
      final list = response.data?['data'] as List?;
      return list
              ?.map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
