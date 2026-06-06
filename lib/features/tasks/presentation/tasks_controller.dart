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
    this.statusId,
    this.prioridadeId,
    this.departamentoId,
    this.projetoId,
    this.responsavelId,
  });

  final List<TaskItem> items;
  final int page;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String search;
  final int? statusId;
  final int? prioridadeId;
  final int? departamentoId;
  final int? projetoId;
  final int? responsavelId;

  TasksState copyWith({
    List<TaskItem>? items,
    int? page,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? search,
    int? statusId,
    int? prioridadeId,
    int? departamentoId,
    int? projetoId,
    int? responsavelId,
  }) {
    return TasksState(
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      search: search ?? this.search,
      statusId: statusId ?? this.statusId,
      prioridadeId: prioridadeId ?? this.prioridadeId,
      departamentoId: departamentoId ?? this.departamentoId,
      projetoId: projetoId ?? this.projetoId,
      responsavelId: responsavelId ?? this.responsavelId,
    );
  }

  bool get hasFilters =>
      statusId != null ||
      prioridadeId != null ||
      departamentoId != null ||
      projetoId != null ||
      responsavelId != null;
}

final tasksControllerProvider =
    NotifierProvider<TasksController, TasksState>(TasksController.new);

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
        q: state.search,
        statusId: state.statusId,
        prioridadeId: state.prioridadeId,
        departamentoId: state.departamentoId,
        projetoId: state.projetoId,
        responsavelId: state.responsavelId,
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
        q: state.search,
        statusId: state.statusId,
        prioridadeId: state.prioridadeId,
        departamentoId: state.departamentoId,
        projetoId: state.projetoId,
        responsavelId: state.responsavelId,
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

  void setStatusId(int? value) {
    state = state.copyWith(statusId: value);
    refresh();
  }

  void setPrioridadeId(int? value) {
    state = state.copyWith(prioridadeId: value);
    refresh();
  }

  void applyAdvancedFilters({
    int? departamentoId,
    int? projetoId,
    int? responsavelId,
  }) {
    state = state.copyWith(
      departamentoId: departamentoId,
      projetoId: projetoId,
      responsavelId: responsavelId,
    );
    refresh();
  }

  void clearFilters() {
    state = TasksState(items: state.items, search: state.search);
    refresh();
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
    final created = await _repository.createTask(
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
    state = state.copyWith(
      items: [created, ...state.items],
    );
    return created;
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
    final updated = await _repository.updateTask(
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
    state = state.copyWith(
      items: state.items.map((task) => task.id == id ? updated : task).toList(),
    );
    return updated;
  }

  Future<void> deleteTask(int id) async {
    await _repository.deleteTask(id);
    state = state.copyWith(
      items: state.items.where((task) => task.id != id).toList(),
    );
  }
}
