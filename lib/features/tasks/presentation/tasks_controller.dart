import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/task_model.dart';
import '../../../data/repositories/tasks_repository.dart';

class TasksState {
  const TasksState({
    this.items = const [],
    this.page = 1,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.search = '',
    this.status,
    this.prioridade,
    this.departamento,
    this.projeto,
    this.responsavel,
  });

  final List<TaskItem> items;
  final int page;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String search;
  final String? status;
  final String? prioridade;
  final String? departamento;
  final String? projeto;
  final String? responsavel;

  TasksState copyWith({
    List<TaskItem>? items,
    int? page,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? search,
    String? status,
    String? prioridade,
    String? departamento,
    String? projeto,
    String? responsavel,
  }) {
    return TasksState(
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      search: search ?? this.search,
      status: status ?? this.status,
      prioridade: prioridade ?? this.prioridade,
      departamento: departamento ?? this.departamento,
      projeto: projeto ?? this.projeto,
      responsavel: responsavel ?? this.responsavel,
    );
  }

  bool get hasFilters =>
      (status?.isNotEmpty ?? false) ||
      (prioridade?.isNotEmpty ?? false) ||
      (departamento?.isNotEmpty ?? false) ||
      (projeto?.isNotEmpty ?? false) ||
      (responsavel?.isNotEmpty ?? false);
}

final tasksControllerProvider = NotifierProvider<TasksController, TasksState>(
  TasksController.new,
);

class TasksController extends Notifier<TasksState> {
  late final TasksRepository _repository;

  @override
  TasksState build() {
    _repository = ref.watch(tasksRepositoryProvider);
    Future.microtask(refresh);
    return const TasksState(isLoading: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null, page: 1);
    try {
      final response = await _repository.getTasks(
        page: 1,
        search: state.search,
        status: state.status,
        prioridade: state.prioridade,
        departamento: state.departamento,
        projeto: state.projeto,
        responsavel: state.responsavel,
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
      final response = await _repository.getTasks(
        page: state.page + 1,
        search: state.search,
        status: state.status,
        prioridade: state.prioridade,
        departamento: state.departamento,
        projeto: state.projeto,
        responsavel: state.responsavel,
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

  void setStatus(String? value) {
    state = TasksState(
      items: state.items,
      search: state.search,
      status: value,
      prioridade: state.prioridade,
      departamento: state.departamento,
      projeto: state.projeto,
      responsavel: state.responsavel,
    );
    refresh();
  }

  void setPrioridade(String? value) {
    state = TasksState(
      items: state.items,
      search: state.search,
      status: state.status,
      prioridade: value,
      departamento: state.departamento,
      projeto: state.projeto,
      responsavel: state.responsavel,
    );
    refresh();
  }

  void applyAdvancedFilters({
    String? departamento,
    String? projeto,
    String? responsavel,
  }) {
    state = state.copyWith(
      departamento: departamento,
      projeto: projeto,
      responsavel: responsavel,
    );
    refresh();
  }

  void clearFilters() {
    state = TasksState(items: state.items, search: state.search);
    refresh();
  }

  Future<TaskItem> updateTask({
    required int id,
    String? status,
    int? responsavelId,
  }) async {
    final updated = await _repository.updateTask(
      id: id,
      status: status,
      responsavelId: responsavelId,
    );
    state = state.copyWith(
      items: state.items.map((task) => task.id == id ? updated : task).toList(),
    );
    return updated;
  }
}
