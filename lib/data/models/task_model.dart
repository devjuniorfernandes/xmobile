import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskItem with _$TaskItem {
  const factory TaskItem({
    required int id,
    required String titulo,
    String? descricao,
    @JsonKey(name: 'data_prazo') String? dataPrazo,
    @JsonKey(name: 'data_conclusao') String? dataConclusao,
    @JsonKey(name: 'data_entrega_real') String? dataEntregaReal,
    @JsonKey(name: 'entregue_atrasado', fromJson: _boolFromJson)
    @Default(false)
    bool entregueAtrasado,
    @JsonKey(name: 'total_retrabalho') @Default(0) int totalRetrabalho,
    @JsonKey(name: 'foi_retrabalho', fromJson: _boolFromJson)
    @Default(false)
    bool foiRetrabalho,
    @JsonKey(name: 'nota_execucao') String? notaExecucao,
    @JsonKey(name: 'aprovada_sem_retrabalho', fromJson: _boolFromJson)
    @Default(false)
    bool aprovadaSemRetrabalho,
    @JsonKey(fromJson: _entityFromJson) NamedEntity? projeto,
    @JsonKey(fromJson: _entityFromJson) NamedEntity? departamento,
    @JsonKey(fromJson: _entityFromJson) NamedEntity? responsavel,
    @JsonKey(fromJson: _entityFromJson) NamedEntity? status,
    @JsonKey(fromJson: _entityFromJson) NamedEntity? prioridade,
  }) = _TaskItem;

  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);
}

bool _boolFromJson(Object? value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    return value == '1' || value.toLowerCase() == 'true';
  }
  return false;
}

NamedEntity? _entityFromJson(Object? value) {
  if (value == null) return null;
  if (value is String) return NamedEntity(id: 0, nome: value);
  if (value is num) {
    return NamedEntity(id: value.toInt(), nome: value.toString());
  }
  if (value is Map<String, dynamic>) {
    final id = (value['id'] as num?)?.toInt() ?? 0;
    final nome =
        (value['nome'] ?? value['name'] ?? value['titulo'] ?? value['email'])
            ?.toString() ??
        'Não informado';
    return NamedEntity(id: id, nome: nome);
  }
  return null;
}
