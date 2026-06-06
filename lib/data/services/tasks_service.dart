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
    String? q,
    int? statusId,
    int? prioridadeId,
    int? departamentoId,
    int? projetoId,
    int? responsavelId,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'page': page,
        if (q != null && q.isNotEmpty) 'q': q,
        'status_id':? statusId,
        'prioridade_id':? prioridadeId,
        'departamento_id':? departamentoId,
        'projeto_id':? projetoId,
        'responsavel_id':? responsavelId,
      };

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

  Future<TaskItem> fetchTaskDetail(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiConstants.tasks}/$id',
      );
      final data = response.data?['data'] is Map<String, dynamic>
          ? response.data!['data'] as Map<String, dynamic>
          : response.data ?? {};
      return TaskItem.fromJson(data);
    } catch (error) {
      throw mapDioError(error);
    }
  }

  Future<TaskItem> createTask({
    required String titulo,
    required String descricao,
    required int departamentoId,
    required int prioridadeId,
    int? projetoId,
    int? usuarioId,
    int? statusId,
    String? dataPrazo,
    String? dataConclusao,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.tasks,
        data: {
          'titulo': titulo,
          'descricao': descricao,
          'departamento_id': departamentoId,
          'prioridade_id': prioridadeId,
          'projeto_id':? projetoId,
          'usuario_id':? usuarioId,
          'status_id':? statusId,
          if (dataPrazo != null && dataPrazo.isNotEmpty)
            'data_prazo': dataPrazo,
          if (dataConclusao != null && dataConclusao.isNotEmpty)
            'data_conclusao': dataConclusao,
        },
      );
      final data = response.data?['data'] is Map<String, dynamic>
          ? response.data!['data'] as Map<String, dynamic>
          : response.data ?? {};
      return TaskItem.fromJson(data);
    } catch (error) {
      throw mapDioError(error);
    }
  }

  Future<TaskItem> updateTask({
    required int id,
    required String titulo,
    required String descricao,
    required int departamentoId,
    required int prioridadeId,
    int? projetoId,
    int? usuarioId,
    int? statusId,
    String? dataPrazo,
    String? dataConclusao,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '${ApiConstants.tasks}/$id',
        data: {
          'titulo': titulo,
          'descricao': descricao,
          'departamento_id': departamentoId,
          'prioridade_id': prioridadeId,
          'projeto_id': projetoId,
          'usuario_id': usuarioId,
          'status_id': statusId,
          'data_prazo': dataPrazo,
          'data_conclusao': dataConclusao,
        },
      );
      final data = response.data?['data'] is Map<String, dynamic>
          ? response.data!['data'] as Map<String, dynamic>
          : response.data ?? {};
      return TaskItem.fromJson(data);
    } catch (error) {
      throw mapDioError(error);
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _dio.delete<dynamic>('${ApiConstants.tasks}/$id');
    } catch (error) {
      throw mapDioError(error);
    }
  }
}
