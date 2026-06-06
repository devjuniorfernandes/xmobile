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
    String? q,
    int? statusId,
    int? prioridadeId,
    int? departamentoId,
    int? projetoId,
    int? responsavelId,
  }) {
    return _service.fetchTasks(
      page: page,
      q: q,
      statusId: statusId,
      prioridadeId: prioridadeId,
      departamentoId: departamentoId,
      projetoId: projetoId,
      responsavelId: responsavelId,
    );
  }

  Future<TaskItem> getTaskDetail(int id) {
    return _service.fetchTaskDetail(id);
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
  }) {
    return _service.createTask(
      titulo: titulo,
      descricao: descricao,
      departamentoId: departamentoId,
      prioridadeId: prioridadeId,
      projetoId: projetoId,
      usuarioId: usuarioId,
      statusId: statusId,
      dataPrazo: dataPrazo,
      dataConclusao: dataConclusao,
    );
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
  }) {
    return _service.updateTask(
      id: id,
      titulo: titulo,
      descricao: descricao,
      departamentoId: departamentoId,
      prioridadeId: prioridadeId,
      projetoId: projetoId,
      usuarioId: usuarioId,
      statusId: statusId,
      dataPrazo: dataPrazo,
      dataConclusao: dataConclusao,
    );
  }

  Future<void> deleteTask(int id) {
    return _service.deleteTask(id);
  }
}
