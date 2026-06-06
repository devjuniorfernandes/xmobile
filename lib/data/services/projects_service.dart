import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../../features/shared/paginated_response.dart';
import '../models/project_model.dart';

final projectsServiceProvider = Provider<ProjectsService>((ref) {
  return ProjectsService(ref.watch(dioProvider));
});

class ProjectsService {
  ProjectsService(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<Project>> fetchProjects({
    int page = 1,
    String? q,
    String? statusProjeto,
    int? empresaId,
    int? responsavelId,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.projects,
        queryParameters: {
          'page': page,
          if (q != null && q.isNotEmpty) 'q': q,
          if (statusProjeto != null && statusProjeto.isNotEmpty)
            'status_projeto': statusProjeto,
          'empresa_id':? empresaId,
          'responsavel_id':? responsavelId,
        },
      );
      return PaginatedResponse.fromLaravel(
        response.data ?? {},
        Project.fromJson,
      );
    } catch (error) {
      throw mapDioError(error);
    }
  }

  Future<Project> fetchProjectDetail(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiConstants.projects}/$id',
      );
      final data = response.data?['data'] is Map<String, dynamic>
          ? response.data!['data'] as Map<String, dynamic>
          : response.data ?? {};
      return Project.fromJson(data);
    } catch (error) {
      throw mapDioError(error);
    }
  }

  Future<Project> createProject({
    required String nome,
    required int empresaId,
    required int usuarioId,
    required String dataInicio,
    String? dataPrazo,
    String? descricao,
    String? statusProjeto,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.projects,
        data: {
          'nome': nome,
          'empresa_id': empresaId,
          'usuario_id': usuarioId,
          'data_inicio': dataInicio,
          if (dataPrazo != null && dataPrazo.isNotEmpty) 'data_prazo': dataPrazo,
          if (descricao != null && descricao.isNotEmpty) 'descricao': descricao,
          if (statusProjeto != null && statusProjeto.isNotEmpty)
            'status_projeto': statusProjeto,
        },
      );
      final data = response.data?['data'] is Map<String, dynamic>
          ? response.data!['data'] as Map<String, dynamic>
          : response.data ?? {};
      return Project.fromJson(data);
    } catch (error) {
      throw mapDioError(error);
    }
  }

  Future<Project> updateProject({
    required int id,
    required String nome,
    required int empresaId,
    required int usuarioId,
    required String dataInicio,
    String? dataPrazo,
    String? descricao,
    String? statusProjeto,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '${ApiConstants.projects}/$id',
        data: {
          'nome': nome,
          'empresa_id': empresaId,
          'usuario_id': usuarioId,
          'data_inicio': dataInicio,
          if (dataPrazo != null && dataPrazo.isNotEmpty) 'data_prazo': dataPrazo,
          if (descricao != null && descricao.isNotEmpty) 'descricao': descricao,
          if (statusProjeto != null && statusProjeto.isNotEmpty)
            'status_projeto': statusProjeto,
        },
      );
      final data = response.data?['data'] is Map<String, dynamic>
          ? response.data!['data'] as Map<String, dynamic>
          : response.data ?? {};
      return Project.fromJson(data);
    } catch (error) {
      throw mapDioError(error);
    }
  }

  Future<void> deleteProject(int id) async {
    try {
      await _dio.delete<dynamic>('${ApiConstants.projects}/$id');
    } catch (error) {
      throw mapDioError(error);
    }
  }
}
