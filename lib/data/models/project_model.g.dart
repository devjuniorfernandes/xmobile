// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Project _$ProjectFromJson(Map<String, dynamic> json) => _Project(
  id: (json['id'] as num).toInt(),
  nome: json['nome'] as String,
  descricao: json['descricao'] as String?,
  statusProjeto: _labelFromJson(json['status_projeto']),
  dataInicio: json['data_inicio'] as String?,
  dataPrazo: json['data_prazo'] as String?,
  dataFim: json['data_fim'] as String?,
  empresa: json['empresa'] == null
      ? null
      : ProjectCompany.fromJson(json['empresa'] as Map<String, dynamic>),
  responsavel: _responsibleFromJson(json['responsavel']),
  metricas: json['metricas'] == null
      ? null
      : ProjectMetrics.fromJson(json['metricas'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
  'id': instance.id,
  'nome': instance.nome,
  'descricao': instance.descricao,
  'status_projeto': instance.statusProjeto,
  'data_inicio': instance.dataInicio,
  'data_prazo': instance.dataPrazo,
  'data_fim': instance.dataFim,
  'empresa': instance.empresa,
  'responsavel': instance.responsavel,
  'metricas': instance.metricas,
};

_ProjectCompany _$ProjectCompanyFromJson(Map<String, dynamic> json) =>
    _ProjectCompany(
      id: (json['id'] as num).toInt(),
      nome: json['nome'] as String,
    );

Map<String, dynamic> _$ProjectCompanyToJson(_ProjectCompany instance) =>
    <String, dynamic>{'id': instance.id, 'nome': instance.nome};

_ProjectResponsible _$ProjectResponsibleFromJson(Map<String, dynamic> json) =>
    _ProjectResponsible(
      id: (json['id'] as num).toInt(),
      nome: json['nome'] as String,
      cargo: json['cargo'] as String?,
    );

Map<String, dynamic> _$ProjectResponsibleToJson(_ProjectResponsible instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'cargo': instance.cargo,
    };

_ProjectMetrics _$ProjectMetricsFromJson(Map<String, dynamic> json) =>
    _ProjectMetrics(
      tarefasTotal: (json['tarefas_total'] as num?)?.toInt() ?? 0,
      tarefasConcluidas: (json['tarefas_concluidas'] as num?)?.toInt() ?? 0,
      tarefasEmAtraso: (json['tarefas_em_atraso'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProjectMetricsToJson(_ProjectMetrics instance) =>
    <String, dynamic>{
      'tarefas_total': instance.tarefasTotal,
      'tarefas_concluidas': instance.tarefasConcluidas,
      'tarefas_em_atraso': instance.tarefasEmAtraso,
    };
