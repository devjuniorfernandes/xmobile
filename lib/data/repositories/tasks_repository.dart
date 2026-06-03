import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/shared/paginated_response.dart';
import '../models/task_model.dart';
import '../services/tasks_service.dart';

final tasksRepositoryProvider = Provider<TasksRepository>((ref) {
  return TasksRepository(ref.watch(tasksServiceProvider));
});

class TasksRepository {
  TasksRepository(this._service);

  final TasksService _service;

  Future<PaginatedResponse<TaskItem>> getTasks({
    int page = 1,
    String? search,
    String? status,
    String? prioridade,
    String? departamento,
    String? projeto,
    int? projetoId,
    String? responsavel,
  }) {
    return _service.fetchTasks(
      page: page,
      search: search,
      status: status,
      prioridade: prioridade,
      departamento: departamento,
      projeto: projeto,
      projetoId: projetoId,
      responsavel: responsavel,
    );
  }

  Future<TaskItem> updateTask({
    required int id,
    String? status,
    int? responsavelId,
  }) {
    return _service.updateTask(
      id: id,
      status: status,
      responsavelId: responsavelId,
    );
  }
}
