import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../services/metadata_service.dart';

final metadataRepositoryProvider = Provider<MetadataRepository>((ref) {
  return MetadataRepository(ref.watch(metadataServiceProvider));
});

class MetadataRepository {
  MetadataRepository(this._service);

  final MetadataService _service;

  Future<List<NamedEntity>> getStatusTarefas() => _service.fetchStatusTarefas();
  Future<List<String>> getStatusProjetos() => _service.fetchStatusProjetos();
  Future<List<NamedEntity>> getPrioridades() => _service.fetchPrioridades();
  Future<List<Map<String, dynamic>>> getUsuarios({
    String? papel,
    int? departamentoId,
    String? q,
  }) =>
      _service.fetchUsuarios(
        papel: papel,
        departamentoId: departamentoId,
        q: q,
      );
  Future<List<NamedEntity>> getEmpresas({String? q}) =>
      _service.fetchEmpresas(q: q);
  Future<List<NamedEntity>> getDepartamentos({String? q}) =>
      _service.fetchDepartamentos(q: q);
}
