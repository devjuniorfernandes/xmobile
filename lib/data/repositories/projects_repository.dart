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
    String? search,
  }) {
    return _service.fetchProjects(page: page, search: search);
  }

  Future<Project> updateProject({
    required int id,
    String? status,
    int? responsavelId,
  }) {
    return _service.updateProject(
      id: id,
      status: status,
      responsavelId: responsavelId,
    );
  }
}
