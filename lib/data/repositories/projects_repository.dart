import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/shared/paginated_response.dart';
import '../models/project_model.dart';
import '../services/projects_service.dart';

final projectsRepositoryProvider = Provider<ProjectsRepository>((ref) {
  return ProjectsRepository(ref.watch(projectsServiceProvider));
});

class ProjectsRepository {
  ProjectsRepository(this._service);

  final ProjectsService _service;

  Future<PaginatedResponse<Project>> getProjects({
    int page = 1,
    String? q,
    String? statusProjeto,
    int? empresaId,
    int? responsavelId,
  }) {
    return _service.fetchProjects(
      page: page,
      q: q,
      statusProjeto: statusProjeto,
      empresaId: empresaId,
      responsavelId: responsavelId,
    );
  }

  Future<Project> getProjectDetail(int id) {
    return _service.fetchProjectDetail(id);
  }

  Future<Project> createProject({
    required String nome,
    required int empresaId,
    required int usuarioId,
    required String dataInicio,
    String? dataPrazo,
    String? descricao,
    String? statusProjeto,
  }) {
    return _service.createProject(
      nome: nome,
      empresaId: empresaId,
      usuarioId: usuarioId,
      dataInicio: dataInicio,
      dataPrazo: dataPrazo,
      descricao: descricao,
      statusProjeto: statusProjeto,
    );
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
  }) {
    return _service.updateProject(
      id: id,
      nome: nome,
      empresaId: empresaId,
      usuarioId: usuarioId,
      dataInicio: dataInicio,
      dataPrazo: dataPrazo,
      descricao: descricao,
      statusProjeto: statusProjeto,
    );
  }

  Future<void> deleteProject(int id) {
    return _service.deleteProject(id);
  }
}
