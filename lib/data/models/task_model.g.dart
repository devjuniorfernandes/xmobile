// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskItem _$TaskItemFromJson(Map<String, dynamic> json) => _TaskItem(
  id: (json['id'] as num).toInt(),
  titulo: json['titulo'] as String,
  descricao: json['descricao'] as String?,
  dataPrazo: json['data_prazo'] as String?,
  dataConclusao: json['data_conclusao'] as String?,
  dataEntregaReal: json['data_entrega_real'] as String?,
  entregueAtrasado: json['entregue_atrasado'] == null
      ? false
      : _boolFromJson(json['entregue_atrasado']),
  totalRetrabalho: (json['total_retrabalho'] as num?)?.toInt() ?? 0,
  foiRetrabalho: json['foi_retrabalho'] == null
      ? false
      : _boolFromJson(json['foi_retrabalho']),
  notaExecucao: json['nota_execucao'] as String?,
  aprovadaSemRetrabalho: json['aprovada_sem_retrabalho'] == null
      ? false
      : _boolFromJson(json['aprovada_sem_retrabalho']),
  projeto: _entityFromJson(json['projeto']),
  departamento: _entityFromJson(json['departamento']),
  responsavel: _entityFromJson(json['responsavel']),
  status: _entityFromJson(json['status']),
  prioridade: _entityFromJson(json['prioridade']),
);

Map<String, dynamic> _$TaskItemToJson(_TaskItem instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.titulo,
  'descricao': instance.descricao,
  'data_prazo': instance.dataPrazo,
  'data_conclusao': instance.dataConclusao,
  'data_entrega_real': instance.dataEntregaReal,
  'entregue_atrasado': instance.entregueAtrasado,
  'total_retrabalho': instance.totalRetrabalho,
  'foi_retrabalho': instance.foiRetrabalho,
  'nota_execucao': instance.notaExecucao,
  'aprovada_sem_retrabalho': instance.aprovadaSemRetrabalho,
  'projeto': instance.projeto,
  'departamento': instance.departamento,
  'responsavel': instance.responsavel,
  'status': instance.status,
  'prioridade': instance.prioridade,
};
