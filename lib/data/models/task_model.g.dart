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
  entregueAtrasado: json['entregue_atrasado'] == null
      ? false
      : _boolFromJson(json['entregue_atrasado']),
  projeto: _entityFromJson(json['projeto']),
  departamento: _entityFromJson(json['departamento']),
  responsavel: _entityFromJson(json['responsavel']),
  status: _labelFromJson(json['status']),
  prioridade: _labelFromJson(json['prioridade']),
);

Map<String, dynamic> _$TaskItemToJson(_TaskItem instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.titulo,
  'descricao': instance.descricao,
  'data_prazo': instance.dataPrazo,
  'data_conclusao': instance.dataConclusao,
  'entregue_atrasado': instance.entregueAtrasado,
  'projeto': instance.projeto,
  'departamento': instance.departamento,
  'responsavel': instance.responsavel,
  'status': instance.status,
  'prioridade': instance.prioridade,
};
