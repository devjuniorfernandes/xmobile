import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/metadata_repository.dart';

class MetadataState {
  const MetadataState({
    this.statusTarefas = const [],
    this.statusProjetos = const [],
    this.prioridades = const [],
    this.departamentos = const [],
    this.empresas = const [],
    this.usuarios = const [],
    this.isLoading = false,
    this.error,
  });

  final List<NamedEntity> statusTarefas;
  final List<String> statusProjetos;
  final List<NamedEntity> prioridades;
  final List<NamedEntity> departamentos;
  final List<NamedEntity> empresas;
  final List<Map<String, dynamic>> usuarios;
  final bool isLoading;
  final String? error;

  MetadataState copyWith({
    List<NamedEntity>? statusTarefas,
    List<String>? statusProjetos,
    List<NamedEntity>? prioridades,
    List<NamedEntity>? departamentos,
    List<NamedEntity>? empresas,
    List<Map<String, dynamic>>? usuarios,
    bool? isLoading,
    String? error,
  }) {
    return MetadataState(
      statusTarefas: statusTarefas ?? this.statusTarefas,
      statusProjetos: statusProjetos ?? this.statusProjetos,
      prioridades: prioridades ?? this.prioridades,
      departamentos: departamentos ?? this.departamentos,
      empresas: empresas ?? this.empresas,
      usuarios: usuarios ?? this.usuarios,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final metadataControllerProvider =
    NotifierProvider<MetadataController, MetadataState>(MetadataController.new);

class MetadataController extends Notifier<MetadataState> {
  late final MetadataRepository _repository;

  @override
  MetadataState build() {
    _repository = ref.watch(metadataRepositoryProvider);
    return const MetadataState();
  }

  Future<void> bootstrap() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final results = await Future.wait([
        _repository.getStatusTarefas(),
        _repository.getStatusProjetos(),
        _repository.getPrioridades(),
        _repository.getDepartamentos(),
        _repository.getEmpresas(),
        _repository.getUsuarios(),
      ]);

      state = MetadataState(
        statusTarefas: results[0] as List<NamedEntity>,
        statusProjetos: results[1] as List<String>,
        prioridades: results[2] as List<NamedEntity>,
        departamentos: results[3] as List<NamedEntity>,
        empresas: results[4] as List<NamedEntity>,
        usuarios: results[5] as List<Map<String, dynamic>>,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clear() {
    state = const MetadataState();
  }
}
