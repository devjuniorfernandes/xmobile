import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../../features/shared/paginated_response.dart';
import '../models/task_model.dart';

final tasksServiceProvider = Provider<TasksService>((ref) {
  return TasksService(ref.watch(dioProvider));
});

class TasksService {
  TasksService(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<TaskItem>> fetchTasks({
    int page = 1,
    String? search,
    String? status,
    String? prioridade,
    String? departamento,
    String? projeto,
    int? projetoId,
    String? responsavel,
  }) async {
    try {
      final queryParameters = <String, dynamic>{'page': page};
      if (search != null && search.isNotEmpty) {
        queryParameters['search'] = search;
      }
      if (status != null && status.isNotEmpty) {
        queryParameters['status'] = status;
      }
      if (prioridade != null && prioridade.isNotEmpty) {
        queryParameters['prioridade'] = prioridade;
      }
      if (departamento != null && departamento.isNotEmpty) {
        queryParameters['departamento'] = departamento;
      }
      if (projeto != null && projeto.isNotEmpty) {
        queryParameters['projeto'] = projeto;
      }
      if (projetoId != null) {
        queryParameters['projeto_id'] = projetoId;
      }
      if (responsavel != null && responsavel.isNotEmpty) {
        queryParameters['responsavel'] = responsavel;
      }
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.tasks,
        queryParameters: queryParameters,
      );
      return PaginatedResponse.fromLaravel(
        response.data ?? {},
        TaskItem.fromJson,
      );
    } catch (error) {
      throw mapDioError(error);
    }
  }

  Future<TaskItem> updateTask({
    required int id,
    String? status,
    int? responsavelId,
  }) async {
    try {
      final payload = <String, dynamic>{};
      if (status != null && status.isNotEmpty) {
        payload['status'] = status;
      }
      if (responsavelId != null) {
        payload['responsavel_id'] = responsavelId;
      }
      final response = await _dio.patch<Map<String, dynamic>>(
        '${ApiConstants.tasks}/$id',
        data: payload,
      );
      final data = response.data?['data'] is Map<String, dynamic>
          ? response.data!['data'] as Map<String, dynamic>
          : response.data ?? {};
      return TaskItem.fromJson(data);
    } catch (error) {
      throw mapDioError(error);
    }
  }
}
