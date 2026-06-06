// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Project {

 int get id; String get nome; String? get descricao;@JsonKey(name: 'status_projeto', fromJson: _labelFromJson) String? get statusProjeto;@JsonKey(name: 'data_inicio') String? get dataInicio;@JsonKey(name: 'data_prazo') String? get dataPrazo;@JsonKey(name: 'data_fim') String? get dataFim; ProjectCompany? get empresa;@JsonKey(fromJson: _responsibleFromJson) ProjectResponsible? get responsavel; ProjectMetrics? get metricas; List<ProjectReference>? get referencias;
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCopyWith<Project> get copyWith => _$ProjectCopyWithImpl<Project>(this as Project, _$identity);

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Project&&(identical(other.id, id) || other.id == id)&&(identical(other.nome, nome) || other.nome == nome)&&(identical(other.descricao, descricao) || other.descricao == descricao)&&(identical(other.statusProjeto, statusProjeto) || other.statusProjeto == statusProjeto)&&(identical(other.dataInicio, dataInicio) || other.dataInicio == dataInicio)&&(identical(other.dataPrazo, dataPrazo) || other.dataPrazo == dataPrazo)&&(identical(other.dataFim, dataFim) || other.dataFim == dataFim)&&(identical(other.empresa, empresa) || other.empresa == empresa)&&(identical(other.responsavel, responsavel) || other.responsavel == responsavel)&&(identical(other.metricas, metricas) || other.metricas == metricas)&&const DeepCollectionEquality().equals(other.referencias, referencias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nome,descricao,statusProjeto,dataInicio,dataPrazo,dataFim,empresa,responsavel,metricas,const DeepCollectionEquality().hash(referencias));

@override
String toString() {
  return 'Project(id: $id, nome: $nome, descricao: $descricao, statusProjeto: $statusProjeto, dataInicio: $dataInicio, dataPrazo: $dataPrazo, dataFim: $dataFim, empresa: $empresa, responsavel: $responsavel, metricas: $metricas, referencias: $referencias)';
}


}

/// @nodoc
abstract mixin class $ProjectCopyWith<$Res>  {
  factory $ProjectCopyWith(Project value, $Res Function(Project) _then) = _$ProjectCopyWithImpl;
@useResult
$Res call({
 int id, String nome, String? descricao,@JsonKey(name: 'status_projeto', fromJson: _labelFromJson) String? statusProjeto,@JsonKey(name: 'data_inicio') String? dataInicio,@JsonKey(name: 'data_prazo') String? dataPrazo,@JsonKey(name: 'data_fim') String? dataFim, ProjectCompany? empresa,@JsonKey(fromJson: _responsibleFromJson) ProjectResponsible? responsavel, ProjectMetrics? metricas, List<ProjectReference>? referencias
});


$ProjectCompanyCopyWith<$Res>? get empresa;$ProjectResponsibleCopyWith<$Res>? get responsavel;$ProjectMetricsCopyWith<$Res>? get metricas;

}
/// @nodoc
class _$ProjectCopyWithImpl<$Res>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._self, this._then);

  final Project _self;
  final $Res Function(Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nome = null,Object? descricao = freezed,Object? statusProjeto = freezed,Object? dataInicio = freezed,Object? dataPrazo = freezed,Object? dataFim = freezed,Object? empresa = freezed,Object? responsavel = freezed,Object? metricas = freezed,Object? referencias = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nome: null == nome ? _self.nome : nome // ignore: cast_nullable_to_non_nullable
as String,descricao: freezed == descricao ? _self.descricao : descricao // ignore: cast_nullable_to_non_nullable
as String?,statusProjeto: freezed == statusProjeto ? _self.statusProjeto : statusProjeto // ignore: cast_nullable_to_non_nullable
as String?,dataInicio: freezed == dataInicio ? _self.dataInicio : dataInicio // ignore: cast_nullable_to_non_nullable
as String?,dataPrazo: freezed == dataPrazo ? _self.dataPrazo : dataPrazo // ignore: cast_nullable_to_non_nullable
as String?,dataFim: freezed == dataFim ? _self.dataFim : dataFim // ignore: cast_nullable_to_non_nullable
as String?,empresa: freezed == empresa ? _self.empresa : empresa // ignore: cast_nullable_to_non_nullable
as ProjectCompany?,responsavel: freezed == responsavel ? _self.responsavel : responsavel // ignore: cast_nullable_to_non_nullable
as ProjectResponsible?,metricas: freezed == metricas ? _self.metricas : metricas // ignore: cast_nullable_to_non_nullable
as ProjectMetrics?,referencias: freezed == referencias ? _self.referencias : referencias // ignore: cast_nullable_to_non_nullable
as List<ProjectReference>?,
  ));
}
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCompanyCopyWith<$Res>? get empresa {
    if (_self.empresa == null) {
    return null;
  }

  return $ProjectCompanyCopyWith<$Res>(_self.empresa!, (value) {
    return _then(_self.copyWith(empresa: value));
  });
}/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectResponsibleCopyWith<$Res>? get responsavel {
    if (_self.responsavel == null) {
    return null;
  }

  return $ProjectResponsibleCopyWith<$Res>(_self.responsavel!, (value) {
    return _then(_self.copyWith(responsavel: value));
  });
}/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectMetricsCopyWith<$Res>? get metricas {
    if (_self.metricas == null) {
    return null;
  }

  return $ProjectMetricsCopyWith<$Res>(_self.metricas!, (value) {
    return _then(_self.copyWith(metricas: value));
  });
}
}


/// Adds pattern-matching-related methods to [Project].
extension ProjectPatterns on Project {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Project value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Project value)  $default,){
final _that = this;
switch (_that) {
case _Project():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Project value)?  $default,){
final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nome,  String? descricao, @JsonKey(name: 'status_projeto', fromJson: _labelFromJson)  String? statusProjeto, @JsonKey(name: 'data_inicio')  String? dataInicio, @JsonKey(name: 'data_prazo')  String? dataPrazo, @JsonKey(name: 'data_fim')  String? dataFim,  ProjectCompany? empresa, @JsonKey(fromJson: _responsibleFromJson)  ProjectResponsible? responsavel,  ProjectMetrics? metricas,  List<ProjectReference>? referencias)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.nome,_that.descricao,_that.statusProjeto,_that.dataInicio,_that.dataPrazo,_that.dataFim,_that.empresa,_that.responsavel,_that.metricas,_that.referencias);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nome,  String? descricao, @JsonKey(name: 'status_projeto', fromJson: _labelFromJson)  String? statusProjeto, @JsonKey(name: 'data_inicio')  String? dataInicio, @JsonKey(name: 'data_prazo')  String? dataPrazo, @JsonKey(name: 'data_fim')  String? dataFim,  ProjectCompany? empresa, @JsonKey(fromJson: _responsibleFromJson)  ProjectResponsible? responsavel,  ProjectMetrics? metricas,  List<ProjectReference>? referencias)  $default,) {final _that = this;
switch (_that) {
case _Project():
return $default(_that.id,_that.nome,_that.descricao,_that.statusProjeto,_that.dataInicio,_that.dataPrazo,_that.dataFim,_that.empresa,_that.responsavel,_that.metricas,_that.referencias);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nome,  String? descricao, @JsonKey(name: 'status_projeto', fromJson: _labelFromJson)  String? statusProjeto, @JsonKey(name: 'data_inicio')  String? dataInicio, @JsonKey(name: 'data_prazo')  String? dataPrazo, @JsonKey(name: 'data_fim')  String? dataFim,  ProjectCompany? empresa, @JsonKey(fromJson: _responsibleFromJson)  ProjectResponsible? responsavel,  ProjectMetrics? metricas,  List<ProjectReference>? referencias)?  $default,) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.nome,_that.descricao,_that.statusProjeto,_that.dataInicio,_that.dataPrazo,_that.dataFim,_that.empresa,_that.responsavel,_that.metricas,_that.referencias);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Project implements Project {
  const _Project({required this.id, required this.nome, this.descricao, @JsonKey(name: 'status_projeto', fromJson: _labelFromJson) this.statusProjeto, @JsonKey(name: 'data_inicio') this.dataInicio, @JsonKey(name: 'data_prazo') this.dataPrazo, @JsonKey(name: 'data_fim') this.dataFim, this.empresa, @JsonKey(fromJson: _responsibleFromJson) this.responsavel, this.metricas, final  List<ProjectReference>? referencias}): _referencias = referencias;
  factory _Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

@override final  int id;
@override final  String nome;
@override final  String? descricao;
@override@JsonKey(name: 'status_projeto', fromJson: _labelFromJson) final  String? statusProjeto;
@override@JsonKey(name: 'data_inicio') final  String? dataInicio;
@override@JsonKey(name: 'data_prazo') final  String? dataPrazo;
@override@JsonKey(name: 'data_fim') final  String? dataFim;
@override final  ProjectCompany? empresa;
@override@JsonKey(fromJson: _responsibleFromJson) final  ProjectResponsible? responsavel;
@override final  ProjectMetrics? metricas;
 final  List<ProjectReference>? _referencias;
@override List<ProjectReference>? get referencias {
  final value = _referencias;
  if (value == null) return null;
  if (_referencias is EqualUnmodifiableListView) return _referencias;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectCopyWith<_Project> get copyWith => __$ProjectCopyWithImpl<_Project>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Project&&(identical(other.id, id) || other.id == id)&&(identical(other.nome, nome) || other.nome == nome)&&(identical(other.descricao, descricao) || other.descricao == descricao)&&(identical(other.statusProjeto, statusProjeto) || other.statusProjeto == statusProjeto)&&(identical(other.dataInicio, dataInicio) || other.dataInicio == dataInicio)&&(identical(other.dataPrazo, dataPrazo) || other.dataPrazo == dataPrazo)&&(identical(other.dataFim, dataFim) || other.dataFim == dataFim)&&(identical(other.empresa, empresa) || other.empresa == empresa)&&(identical(other.responsavel, responsavel) || other.responsavel == responsavel)&&(identical(other.metricas, metricas) || other.metricas == metricas)&&const DeepCollectionEquality().equals(other._referencias, _referencias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nome,descricao,statusProjeto,dataInicio,dataPrazo,dataFim,empresa,responsavel,metricas,const DeepCollectionEquality().hash(_referencias));

@override
String toString() {
  return 'Project(id: $id, nome: $nome, descricao: $descricao, statusProjeto: $statusProjeto, dataInicio: $dataInicio, dataPrazo: $dataPrazo, dataFim: $dataFim, empresa: $empresa, responsavel: $responsavel, metricas: $metricas, referencias: $referencias)';
}


}

/// @nodoc
abstract mixin class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) _then) = __$ProjectCopyWithImpl;
@override @useResult
$Res call({
 int id, String nome, String? descricao,@JsonKey(name: 'status_projeto', fromJson: _labelFromJson) String? statusProjeto,@JsonKey(name: 'data_inicio') String? dataInicio,@JsonKey(name: 'data_prazo') String? dataPrazo,@JsonKey(name: 'data_fim') String? dataFim, ProjectCompany? empresa,@JsonKey(fromJson: _responsibleFromJson) ProjectResponsible? responsavel, ProjectMetrics? metricas, List<ProjectReference>? referencias
});


@override $ProjectCompanyCopyWith<$Res>? get empresa;@override $ProjectResponsibleCopyWith<$Res>? get responsavel;@override $ProjectMetricsCopyWith<$Res>? get metricas;

}
/// @nodoc
class __$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(this._self, this._then);

  final _Project _self;
  final $Res Function(_Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nome = null,Object? descricao = freezed,Object? statusProjeto = freezed,Object? dataInicio = freezed,Object? dataPrazo = freezed,Object? dataFim = freezed,Object? empresa = freezed,Object? responsavel = freezed,Object? metricas = freezed,Object? referencias = freezed,}) {
  return _then(_Project(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nome: null == nome ? _self.nome : nome // ignore: cast_nullable_to_non_nullable
as String,descricao: freezed == descricao ? _self.descricao : descricao // ignore: cast_nullable_to_non_nullable
as String?,statusProjeto: freezed == statusProjeto ? _self.statusProjeto : statusProjeto // ignore: cast_nullable_to_non_nullable
as String?,dataInicio: freezed == dataInicio ? _self.dataInicio : dataInicio // ignore: cast_nullable_to_non_nullable
as String?,dataPrazo: freezed == dataPrazo ? _self.dataPrazo : dataPrazo // ignore: cast_nullable_to_non_nullable
as String?,dataFim: freezed == dataFim ? _self.dataFim : dataFim // ignore: cast_nullable_to_non_nullable
as String?,empresa: freezed == empresa ? _self.empresa : empresa // ignore: cast_nullable_to_non_nullable
as ProjectCompany?,responsavel: freezed == responsavel ? _self.responsavel : responsavel // ignore: cast_nullable_to_non_nullable
as ProjectResponsible?,metricas: freezed == metricas ? _self.metricas : metricas // ignore: cast_nullable_to_non_nullable
as ProjectMetrics?,referencias: freezed == referencias ? _self._referencias : referencias // ignore: cast_nullable_to_non_nullable
as List<ProjectReference>?,
  ));
}

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCompanyCopyWith<$Res>? get empresa {
    if (_self.empresa == null) {
    return null;
  }

  return $ProjectCompanyCopyWith<$Res>(_self.empresa!, (value) {
    return _then(_self.copyWith(empresa: value));
  });
}/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectResponsibleCopyWith<$Res>? get responsavel {
    if (_self.responsavel == null) {
    return null;
  }

  return $ProjectResponsibleCopyWith<$Res>(_self.responsavel!, (value) {
    return _then(_self.copyWith(responsavel: value));
  });
}/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectMetricsCopyWith<$Res>? get metricas {
    if (_self.metricas == null) {
    return null;
  }

  return $ProjectMetricsCopyWith<$Res>(_self.metricas!, (value) {
    return _then(_self.copyWith(metricas: value));
  });
}
}


/// @nodoc
mixin _$ProjectCompany {

 int get id; String get nome;
/// Create a copy of ProjectCompany
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCompanyCopyWith<ProjectCompany> get copyWith => _$ProjectCompanyCopyWithImpl<ProjectCompany>(this as ProjectCompany, _$identity);

  /// Serializes this ProjectCompany to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectCompany&&(identical(other.id, id) || other.id == id)&&(identical(other.nome, nome) || other.nome == nome));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nome);

@override
String toString() {
  return 'ProjectCompany(id: $id, nome: $nome)';
}


}

/// @nodoc
abstract mixin class $ProjectCompanyCopyWith<$Res>  {
  factory $ProjectCompanyCopyWith(ProjectCompany value, $Res Function(ProjectCompany) _then) = _$ProjectCompanyCopyWithImpl;
@useResult
$Res call({
 int id, String nome
});




}
/// @nodoc
class _$ProjectCompanyCopyWithImpl<$Res>
    implements $ProjectCompanyCopyWith<$Res> {
  _$ProjectCompanyCopyWithImpl(this._self, this._then);

  final ProjectCompany _self;
  final $Res Function(ProjectCompany) _then;

/// Create a copy of ProjectCompany
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nome = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nome: null == nome ? _self.nome : nome // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectCompany].
extension ProjectCompanyPatterns on ProjectCompany {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectCompany value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectCompany() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectCompany value)  $default,){
final _that = this;
switch (_that) {
case _ProjectCompany():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectCompany value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectCompany() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectCompany() when $default != null:
return $default(_that.id,_that.nome);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nome)  $default,) {final _that = this;
switch (_that) {
case _ProjectCompany():
return $default(_that.id,_that.nome);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nome)?  $default,) {final _that = this;
switch (_that) {
case _ProjectCompany() when $default != null:
return $default(_that.id,_that.nome);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectCompany implements ProjectCompany {
  const _ProjectCompany({required this.id, required this.nome});
  factory _ProjectCompany.fromJson(Map<String, dynamic> json) => _$ProjectCompanyFromJson(json);

@override final  int id;
@override final  String nome;

/// Create a copy of ProjectCompany
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectCompanyCopyWith<_ProjectCompany> get copyWith => __$ProjectCompanyCopyWithImpl<_ProjectCompany>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectCompanyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectCompany&&(identical(other.id, id) || other.id == id)&&(identical(other.nome, nome) || other.nome == nome));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nome);

@override
String toString() {
  return 'ProjectCompany(id: $id, nome: $nome)';
}


}

/// @nodoc
abstract mixin class _$ProjectCompanyCopyWith<$Res> implements $ProjectCompanyCopyWith<$Res> {
  factory _$ProjectCompanyCopyWith(_ProjectCompany value, $Res Function(_ProjectCompany) _then) = __$ProjectCompanyCopyWithImpl;
@override @useResult
$Res call({
 int id, String nome
});




}
/// @nodoc
class __$ProjectCompanyCopyWithImpl<$Res>
    implements _$ProjectCompanyCopyWith<$Res> {
  __$ProjectCompanyCopyWithImpl(this._self, this._then);

  final _ProjectCompany _self;
  final $Res Function(_ProjectCompany) _then;

/// Create a copy of ProjectCompany
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nome = null,}) {
  return _then(_ProjectCompany(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nome: null == nome ? _self.nome : nome // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProjectResponsible {

 int get id; String get nome; String? get cargo;
/// Create a copy of ProjectResponsible
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectResponsibleCopyWith<ProjectResponsible> get copyWith => _$ProjectResponsibleCopyWithImpl<ProjectResponsible>(this as ProjectResponsible, _$identity);

  /// Serializes this ProjectResponsible to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectResponsible&&(identical(other.id, id) || other.id == id)&&(identical(other.nome, nome) || other.nome == nome)&&(identical(other.cargo, cargo) || other.cargo == cargo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nome,cargo);

@override
String toString() {
  return 'ProjectResponsible(id: $id, nome: $nome, cargo: $cargo)';
}


}

/// @nodoc
abstract mixin class $ProjectResponsibleCopyWith<$Res>  {
  factory $ProjectResponsibleCopyWith(ProjectResponsible value, $Res Function(ProjectResponsible) _then) = _$ProjectResponsibleCopyWithImpl;
@useResult
$Res call({
 int id, String nome, String? cargo
});




}
/// @nodoc
class _$ProjectResponsibleCopyWithImpl<$Res>
    implements $ProjectResponsibleCopyWith<$Res> {
  _$ProjectResponsibleCopyWithImpl(this._self, this._then);

  final ProjectResponsible _self;
  final $Res Function(ProjectResponsible) _then;

/// Create a copy of ProjectResponsible
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nome = null,Object? cargo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nome: null == nome ? _self.nome : nome // ignore: cast_nullable_to_non_nullable
as String,cargo: freezed == cargo ? _self.cargo : cargo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectResponsible].
extension ProjectResponsiblePatterns on ProjectResponsible {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectResponsible value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectResponsible() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectResponsible value)  $default,){
final _that = this;
switch (_that) {
case _ProjectResponsible():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectResponsible value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectResponsible() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nome,  String? cargo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectResponsible() when $default != null:
return $default(_that.id,_that.nome,_that.cargo);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nome,  String? cargo)  $default,) {final _that = this;
switch (_that) {
case _ProjectResponsible():
return $default(_that.id,_that.nome,_that.cargo);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nome,  String? cargo)?  $default,) {final _that = this;
switch (_that) {
case _ProjectResponsible() when $default != null:
return $default(_that.id,_that.nome,_that.cargo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectResponsible implements ProjectResponsible {
  const _ProjectResponsible({required this.id, required this.nome, this.cargo});
  factory _ProjectResponsible.fromJson(Map<String, dynamic> json) => _$ProjectResponsibleFromJson(json);

@override final  int id;
@override final  String nome;
@override final  String? cargo;

/// Create a copy of ProjectResponsible
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectResponsibleCopyWith<_ProjectResponsible> get copyWith => __$ProjectResponsibleCopyWithImpl<_ProjectResponsible>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectResponsibleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectResponsible&&(identical(other.id, id) || other.id == id)&&(identical(other.nome, nome) || other.nome == nome)&&(identical(other.cargo, cargo) || other.cargo == cargo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nome,cargo);

@override
String toString() {
  return 'ProjectResponsible(id: $id, nome: $nome, cargo: $cargo)';
}


}

/// @nodoc
abstract mixin class _$ProjectResponsibleCopyWith<$Res> implements $ProjectResponsibleCopyWith<$Res> {
  factory _$ProjectResponsibleCopyWith(_ProjectResponsible value, $Res Function(_ProjectResponsible) _then) = __$ProjectResponsibleCopyWithImpl;
@override @useResult
$Res call({
 int id, String nome, String? cargo
});




}
/// @nodoc
class __$ProjectResponsibleCopyWithImpl<$Res>
    implements _$ProjectResponsibleCopyWith<$Res> {
  __$ProjectResponsibleCopyWithImpl(this._self, this._then);

  final _ProjectResponsible _self;
  final $Res Function(_ProjectResponsible) _then;

/// Create a copy of ProjectResponsible
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nome = null,Object? cargo = freezed,}) {
  return _then(_ProjectResponsible(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nome: null == nome ? _self.nome : nome // ignore: cast_nullable_to_non_nullable
as String,cargo: freezed == cargo ? _self.cargo : cargo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProjectMetrics {

@JsonKey(name: 'tarefas_total') int get tarefasTotal;@JsonKey(name: 'tarefas_concluidas') int get tarefasConcluidas;@JsonKey(name: 'tarefas_em_atraso') int get tarefasEmAtraso;
/// Create a copy of ProjectMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectMetricsCopyWith<ProjectMetrics> get copyWith => _$ProjectMetricsCopyWithImpl<ProjectMetrics>(this as ProjectMetrics, _$identity);

  /// Serializes this ProjectMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectMetrics&&(identical(other.tarefasTotal, tarefasTotal) || other.tarefasTotal == tarefasTotal)&&(identical(other.tarefasConcluidas, tarefasConcluidas) || other.tarefasConcluidas == tarefasConcluidas)&&(identical(other.tarefasEmAtraso, tarefasEmAtraso) || other.tarefasEmAtraso == tarefasEmAtraso));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tarefasTotal,tarefasConcluidas,tarefasEmAtraso);

@override
String toString() {
  return 'ProjectMetrics(tarefasTotal: $tarefasTotal, tarefasConcluidas: $tarefasConcluidas, tarefasEmAtraso: $tarefasEmAtraso)';
}


}

/// @nodoc
abstract mixin class $ProjectMetricsCopyWith<$Res>  {
  factory $ProjectMetricsCopyWith(ProjectMetrics value, $Res Function(ProjectMetrics) _then) = _$ProjectMetricsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'tarefas_total') int tarefasTotal,@JsonKey(name: 'tarefas_concluidas') int tarefasConcluidas,@JsonKey(name: 'tarefas_em_atraso') int tarefasEmAtraso
});




}
/// @nodoc
class _$ProjectMetricsCopyWithImpl<$Res>
    implements $ProjectMetricsCopyWith<$Res> {
  _$ProjectMetricsCopyWithImpl(this._self, this._then);

  final ProjectMetrics _self;
  final $Res Function(ProjectMetrics) _then;

/// Create a copy of ProjectMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tarefasTotal = null,Object? tarefasConcluidas = null,Object? tarefasEmAtraso = null,}) {
  return _then(_self.copyWith(
tarefasTotal: null == tarefasTotal ? _self.tarefasTotal : tarefasTotal // ignore: cast_nullable_to_non_nullable
as int,tarefasConcluidas: null == tarefasConcluidas ? _self.tarefasConcluidas : tarefasConcluidas // ignore: cast_nullable_to_non_nullable
as int,tarefasEmAtraso: null == tarefasEmAtraso ? _self.tarefasEmAtraso : tarefasEmAtraso // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectMetrics].
extension ProjectMetricsPatterns on ProjectMetrics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectMetrics() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectMetrics value)  $default,){
final _that = this;
switch (_that) {
case _ProjectMetrics():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectMetrics() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'tarefas_total')  int tarefasTotal, @JsonKey(name: 'tarefas_concluidas')  int tarefasConcluidas, @JsonKey(name: 'tarefas_em_atraso')  int tarefasEmAtraso)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectMetrics() when $default != null:
return $default(_that.tarefasTotal,_that.tarefasConcluidas,_that.tarefasEmAtraso);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'tarefas_total')  int tarefasTotal, @JsonKey(name: 'tarefas_concluidas')  int tarefasConcluidas, @JsonKey(name: 'tarefas_em_atraso')  int tarefasEmAtraso)  $default,) {final _that = this;
switch (_that) {
case _ProjectMetrics():
return $default(_that.tarefasTotal,_that.tarefasConcluidas,_that.tarefasEmAtraso);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'tarefas_total')  int tarefasTotal, @JsonKey(name: 'tarefas_concluidas')  int tarefasConcluidas, @JsonKey(name: 'tarefas_em_atraso')  int tarefasEmAtraso)?  $default,) {final _that = this;
switch (_that) {
case _ProjectMetrics() when $default != null:
return $default(_that.tarefasTotal,_that.tarefasConcluidas,_that.tarefasEmAtraso);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectMetrics implements ProjectMetrics {
  const _ProjectMetrics({@JsonKey(name: 'tarefas_total') this.tarefasTotal = 0, @JsonKey(name: 'tarefas_concluidas') this.tarefasConcluidas = 0, @JsonKey(name: 'tarefas_em_atraso') this.tarefasEmAtraso = 0});
  factory _ProjectMetrics.fromJson(Map<String, dynamic> json) => _$ProjectMetricsFromJson(json);

@override@JsonKey(name: 'tarefas_total') final  int tarefasTotal;
@override@JsonKey(name: 'tarefas_concluidas') final  int tarefasConcluidas;
@override@JsonKey(name: 'tarefas_em_atraso') final  int tarefasEmAtraso;

/// Create a copy of ProjectMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectMetricsCopyWith<_ProjectMetrics> get copyWith => __$ProjectMetricsCopyWithImpl<_ProjectMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectMetrics&&(identical(other.tarefasTotal, tarefasTotal) || other.tarefasTotal == tarefasTotal)&&(identical(other.tarefasConcluidas, tarefasConcluidas) || other.tarefasConcluidas == tarefasConcluidas)&&(identical(other.tarefasEmAtraso, tarefasEmAtraso) || other.tarefasEmAtraso == tarefasEmAtraso));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tarefasTotal,tarefasConcluidas,tarefasEmAtraso);

@override
String toString() {
  return 'ProjectMetrics(tarefasTotal: $tarefasTotal, tarefasConcluidas: $tarefasConcluidas, tarefasEmAtraso: $tarefasEmAtraso)';
}


}

/// @nodoc
abstract mixin class _$ProjectMetricsCopyWith<$Res> implements $ProjectMetricsCopyWith<$Res> {
  factory _$ProjectMetricsCopyWith(_ProjectMetrics value, $Res Function(_ProjectMetrics) _then) = __$ProjectMetricsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'tarefas_total') int tarefasTotal,@JsonKey(name: 'tarefas_concluidas') int tarefasConcluidas,@JsonKey(name: 'tarefas_em_atraso') int tarefasEmAtraso
});




}
/// @nodoc
class __$ProjectMetricsCopyWithImpl<$Res>
    implements _$ProjectMetricsCopyWith<$Res> {
  __$ProjectMetricsCopyWithImpl(this._self, this._then);

  final _ProjectMetrics _self;
  final $Res Function(_ProjectMetrics) _then;

/// Create a copy of ProjectMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tarefasTotal = null,Object? tarefasConcluidas = null,Object? tarefasEmAtraso = null,}) {
  return _then(_ProjectMetrics(
tarefasTotal: null == tarefasTotal ? _self.tarefasTotal : tarefasTotal // ignore: cast_nullable_to_non_nullable
as int,tarefasConcluidas: null == tarefasConcluidas ? _self.tarefasConcluidas : tarefasConcluidas // ignore: cast_nullable_to_non_nullable
as int,tarefasEmAtraso: null == tarefasEmAtraso ? _self.tarefasEmAtraso : tarefasEmAtraso // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ProjectReference {

 int get id; String get titulo; String get tipo; String get url; String? get descricao;
/// Create a copy of ProjectReference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectReferenceCopyWith<ProjectReference> get copyWith => _$ProjectReferenceCopyWithImpl<ProjectReference>(this as ProjectReference, _$identity);

  /// Serializes this ProjectReference to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectReference&&(identical(other.id, id) || other.id == id)&&(identical(other.titulo, titulo) || other.titulo == titulo)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.url, url) || other.url == url)&&(identical(other.descricao, descricao) || other.descricao == descricao));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titulo,tipo,url,descricao);

@override
String toString() {
  return 'ProjectReference(id: $id, titulo: $titulo, tipo: $tipo, url: $url, descricao: $descricao)';
}


}

/// @nodoc
abstract mixin class $ProjectReferenceCopyWith<$Res>  {
  factory $ProjectReferenceCopyWith(ProjectReference value, $Res Function(ProjectReference) _then) = _$ProjectReferenceCopyWithImpl;
@useResult
$Res call({
 int id, String titulo, String tipo, String url, String? descricao
});




}
/// @nodoc
class _$ProjectReferenceCopyWithImpl<$Res>
    implements $ProjectReferenceCopyWith<$Res> {
  _$ProjectReferenceCopyWithImpl(this._self, this._then);

  final ProjectReference _self;
  final $Res Function(ProjectReference) _then;

/// Create a copy of ProjectReference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titulo = null,Object? tipo = null,Object? url = null,Object? descricao = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titulo: null == titulo ? _self.titulo : titulo // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,descricao: freezed == descricao ? _self.descricao : descricao // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectReference].
extension ProjectReferencePatterns on ProjectReference {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectReference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectReference() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectReference value)  $default,){
final _that = this;
switch (_that) {
case _ProjectReference():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectReference value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectReference() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titulo,  String tipo,  String url,  String? descricao)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectReference() when $default != null:
return $default(_that.id,_that.titulo,_that.tipo,_that.url,_that.descricao);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titulo,  String tipo,  String url,  String? descricao)  $default,) {final _that = this;
switch (_that) {
case _ProjectReference():
return $default(_that.id,_that.titulo,_that.tipo,_that.url,_that.descricao);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titulo,  String tipo,  String url,  String? descricao)?  $default,) {final _that = this;
switch (_that) {
case _ProjectReference() when $default != null:
return $default(_that.id,_that.titulo,_that.tipo,_that.url,_that.descricao);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectReference implements ProjectReference {
  const _ProjectReference({required this.id, required this.titulo, required this.tipo, required this.url, this.descricao});
  factory _ProjectReference.fromJson(Map<String, dynamic> json) => _$ProjectReferenceFromJson(json);

@override final  int id;
@override final  String titulo;
@override final  String tipo;
@override final  String url;
@override final  String? descricao;

/// Create a copy of ProjectReference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectReferenceCopyWith<_ProjectReference> get copyWith => __$ProjectReferenceCopyWithImpl<_ProjectReference>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectReferenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectReference&&(identical(other.id, id) || other.id == id)&&(identical(other.titulo, titulo) || other.titulo == titulo)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.url, url) || other.url == url)&&(identical(other.descricao, descricao) || other.descricao == descricao));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titulo,tipo,url,descricao);

@override
String toString() {
  return 'ProjectReference(id: $id, titulo: $titulo, tipo: $tipo, url: $url, descricao: $descricao)';
}


}

/// @nodoc
abstract mixin class _$ProjectReferenceCopyWith<$Res> implements $ProjectReferenceCopyWith<$Res> {
  factory _$ProjectReferenceCopyWith(_ProjectReference value, $Res Function(_ProjectReference) _then) = __$ProjectReferenceCopyWithImpl;
@override @useResult
$Res call({
 int id, String titulo, String tipo, String url, String? descricao
});




}
/// @nodoc
class __$ProjectReferenceCopyWithImpl<$Res>
    implements _$ProjectReferenceCopyWith<$Res> {
  __$ProjectReferenceCopyWithImpl(this._self, this._then);

  final _ProjectReference _self;
  final $Res Function(_ProjectReference) _then;

/// Create a copy of ProjectReference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titulo = null,Object? tipo = null,Object? url = null,Object? descricao = freezed,}) {
  return _then(_ProjectReference(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titulo: null == titulo ? _self.titulo : titulo // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,descricao: freezed == descricao ? _self.descricao : descricao // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
