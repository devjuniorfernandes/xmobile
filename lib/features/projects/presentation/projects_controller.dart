import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/project_model.dart';
import '../../../data/repositories/projects_repository.dart';

class ProjectsState {
  const ProjectsState({
    this.items = const [],
    this.page = 1,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.search = '',
  });

  final List<Project> items;
  final int page;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String search;

  ProjectsState copyWith({
    List<Project>? items,
    int? page,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? search,
  }) {
    return ProjectsState(
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      search: search ?? this.search,
    );
  }
}

final projectsControllerProvider =
    NotifierProvider<ProjectsController, ProjectsState>(ProjectsController.new);

class ProjectsController extends Notifier<ProjectsState> {
  late final ProjectsRepository _repository;

  @override
  ProjectsState build() {
    _repository = ref.watch(projectsRepositoryProvider);
    Future.microtask(refresh);
    return const ProjectsState(isLoading: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null, page: 1);
    try {
      final response = await _repository.getProjects(
        page: 1,
        search: state.search,
      );
      state = state.copyWith(
        items: response.items,
        page: response.currentPage,
        hasMore: response.hasMore,
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true, error: null);
    try {
      final response = await _repository.getProjects(
        page: state.page + 1,
        search: state.search,
      );
      state = state.copyWith(
        items: [...state.items, ...response.items],
        page: response.currentPage,
        hasMore: response.hasMore,
        isLoadingMore: false,
      );
    } catch (error) {
      state = state.copyWith(isLoadingMore: false, error: error.toString());
    }
  }

  void search(String value) {
    state = state.copyWith(search: value);
    refresh();
  }

  Future<Project> updateProject({
    required int id,
    String? status,
    int? responsavelId,
  }) async {
    final updated = await _repository.updateProject(
      id: id,
      status: status,
      responsavelId: responsavelId,
    );
    state = state.copyWith(
      items: state.items
          .map((project) => project.id == id ? updated : project)
          .toList(),
    );
    return updated;
  }
}
