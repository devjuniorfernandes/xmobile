import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_model.freezed.dart';
part 'project_model.g.dart';

@freezed
abstract class Project with _$Project {
  const factory Project({
    required int id,
    required String nome,
    String? descricao,
    @JsonKey(name: 'status_projeto', fromJson: _labelFromJson)
    String? statusProjeto,
    @JsonKey(name: 'data_inicio') String? dataInicio,
    @JsonKey(name: 'data_prazo') String? dataPrazo,
    @JsonKey(name: 'data_fim') String? dataFim,
    ProjectCompany? empresa,
    @JsonKey(fromJson: _responsibleFromJson) ProjectResponsible? responsavel,
    ProjectMetrics? metricas,
    List<ProjectReference>? referencias,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

String? _labelFromJson(Object? value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is Map<String, dynamic>) {
    return (value['nome'] ?? value['name'] ?? value['label'])?.toString();
  }
  return value.toString();
}

ProjectResponsible? _responsibleFromJson(Object? value) {
  if (value == null) return null;
  if (value is String) return ProjectResponsible(id: 0, nome: value);
  if (value is Map<String, dynamic>) {
    final cargo = value['cargo'];
    return ProjectResponsible(
      id: (value['id'] as num?)?.toInt() ?? 0,
      nome:
          (value['nome'] ?? value['name'] ?? value['email'])?.toString() ??
          'Não informado',
      cargo: cargo is Map<String, dynamic>
          ? (cargo['nome'] ?? cargo['name'])?.toString()
          : cargo?.toString(),
    );
  }
  return null;
}

@freezed
abstract class ProjectCompany with _$ProjectCompany {
  const factory ProjectCompany({required int id, required String nome}) =
      _ProjectCompany;
  factory ProjectCompany.fromJson(Map<String, dynamic> json) =>
      _$ProjectCompanyFromJson(json);
}

@freezed
abstract class ProjectResponsible with _$ProjectResponsible {
  const factory ProjectResponsible({
    required int id,
    required String nome,
    String? cargo,
  }) = _ProjectResponsible;

  factory ProjectResponsible.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponsibleFromJson(json);
}

@freezed
abstract class ProjectMetrics with _$ProjectMetrics {
  const factory ProjectMetrics({
    @JsonKey(name: 'tarefas_total') @Default(0) int tarefasTotal,
    @JsonKey(name: 'tarefas_concluidas') @Default(0) int tarefasConcluidas,
    @JsonKey(name: 'tarefas_em_atraso') @Default(0) int tarefasEmAtraso,
  }) = _ProjectMetrics;

  factory ProjectMetrics.fromJson(Map<String, dynamic> json) =>
      _$ProjectMetricsFromJson(json);
}

@freezed
abstract class ProjectReference with _$ProjectReference {
  const factory ProjectReference({
    required int id,
    required String titulo,
    required String tipo,
    required String url,
    String? descricao,
  }) = _ProjectReference;

  factory ProjectReference.fromJson(Map<String, dynamic> json) =>
      _$ProjectReferenceFromJson(json);
}
