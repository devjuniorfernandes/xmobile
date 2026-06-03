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
    String? search,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.projects,
        queryParameters: {
          'page': page,
          if (search != null && search.isNotEmpty) 'search': search,
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

  Future<Project> updateProject({
    required int id,
    String? status,
    int? responsavelId,
  }) async {
    try {
      final payload = <String, dynamic>{};
      if (status != null && status.isNotEmpty) {
        payload['status_projeto'] = status;
      }
      if (responsavelId != null) {
        payload['responsavel_id'] = responsavelId;
      }
      final response = await _dio.patch<Map<String, dynamic>>(
        '${ApiConstants.projects}/$id',
        data: payload,
      );
      final data = response.data?['data'] is Map<String, dynamic>
          ? response.data!['data'] as Map<String, dynamic>
          : response.data ?? {};
      return Project.fromJson(data);
    } catch (error) {
      throw mapDioError(error);
    }
  }
}
