// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskItem {

 int get id; String get titulo; String? get descricao;@JsonKey(name: 'data_prazo') String? get dataPrazo;@JsonKey(name: 'data_conclusao') String? get dataConclusao;@JsonKey(name: 'data_entrega_real') String? get dataEntregaReal;@JsonKey(name: 'entregue_atrasado', fromJson: _boolFromJson) bool get entregueAtrasado;@JsonKey(name: 'total_retrabalho') int get totalRetrabalho;@JsonKey(name: 'foi_retrabalho', fromJson: _boolFromJson) bool get foiRetrabalho;@JsonKey(name: 'nota_execucao') String? get notaExecucao;@JsonKey(name: 'aprovada_sem_retrabalho', fromJson: _boolFromJson) bool get aprovadaSemRetrabalho;@JsonKey(fromJson: _entityFromJson) NamedEntity? get projeto;@JsonKey(fromJson: _entityFromJson) NamedEntity? get departamento;@JsonKey(fromJson: _entityFromJson) NamedEntity? get responsavel;@JsonKey(fromJson: _entityFromJson) NamedEntity? get status;@JsonKey(fromJson: _entityFromJson) NamedEntity? get prioridade;
/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskItemCopyWith<TaskItem> get copyWith => _$TaskItemCopyWithImpl<TaskItem>(this as TaskItem, _$identity);

  /// Serializes this TaskItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskItem&&(identical(other.id, id) || other.id == id)&&(identical(other.titulo, titulo) || other.titulo == titulo)&&(identical(other.descricao, descricao) || other.descricao == descricao)&&(identical(other.dataPrazo, dataPrazo) || other.dataPrazo == dataPrazo)&&(identical(other.dataConclusao, dataConclusao) || other.dataConclusao == dataConclusao)&&(identical(other.dataEntregaReal, dataEntregaReal) || other.dataEntregaReal == dataEntregaReal)&&(identical(other.entregueAtrasado, entregueAtrasado) || other.entregueAtrasado == entregueAtrasado)&&(identical(other.totalRetrabalho, totalRetrabalho) || other.totalRetrabalho == totalRetrabalho)&&(identical(other.foiRetrabalho, foiRetrabalho) || other.foiRetrabalho == foiRetrabalho)&&(identical(other.notaExecucao, notaExecucao) || other.notaExecucao == notaExecucao)&&(identical(other.aprovadaSemRetrabalho, aprovadaSemRetrabalho) || other.aprovadaSemRetrabalho == aprovadaSemRetrabalho)&&(identical(other.projeto, projeto) || other.projeto == projeto)&&(identical(other.departamento, departamento) || other.departamento == departamento)&&(identical(other.responsavel, responsavel) || other.responsavel == responsavel)&&(identical(other.status, status) || other.status == status)&&(identical(other.prioridade, prioridade) || other.prioridade == prioridade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titulo,descricao,dataPrazo,dataConclusao,dataEntregaReal,entregueAtrasado,totalRetrabalho,foiRetrabalho,notaExecucao,aprovadaSemRetrabalho,projeto,departamento,responsavel,status,prioridade);

@override
String toString() {
  return 'TaskItem(id: $id, titulo: $titulo, descricao: $descricao, dataPrazo: $dataPrazo, dataConclusao: $dataConclusao, dataEntregaReal: $dataEntregaReal, entregueAtrasado: $entregueAtrasado, totalRetrabalho: $totalRetrabalho, foiRetrabalho: $foiRetrabalho, notaExecucao: $notaExecucao, aprovadaSemRetrabalho: $aprovadaSemRetrabalho, projeto: $projeto, departamento: $departamento, responsavel: $responsavel, status: $status, prioridade: $prioridade)';
}


}

/// @nodoc
abstract mixin class $TaskItemCopyWith<$Res>  {
  factory $TaskItemCopyWith(TaskItem value, $Res Function(TaskItem) _then) = _$TaskItemCopyWithImpl;
@useResult
$Res call({
 int id, String titulo, String? descricao,@JsonKey(name: 'data_prazo') String? dataPrazo,@JsonKey(name: 'data_conclusao') String? dataConclusao,@JsonKey(name: 'data_entrega_real') String? dataEntregaReal,@JsonKey(name: 'entregue_atrasado', fromJson: _boolFromJson) bool entregueAtrasado,@JsonKey(name: 'total_retrabalho') int totalRetrabalho,@JsonKey(name: 'foi_retrabalho', fromJson: _boolFromJson) bool foiRetrabalho,@JsonKey(name: 'nota_execucao') String? notaExecucao,@JsonKey(name: 'aprovada_sem_retrabalho', fromJson: _boolFromJson) bool aprovadaSemRetrabalho,@JsonKey(fromJson: _entityFromJson) NamedEntity? projeto,@JsonKey(fromJson: _entityFromJson) NamedEntity? departamento,@JsonKey(fromJson: _entityFromJson) NamedEntity? responsavel,@JsonKey(fromJson: _entityFromJson) NamedEntity? status,@JsonKey(fromJson: _entityFromJson) NamedEntity? prioridade
});


$NamedEntityCopyWith<$Res>? get projeto;$NamedEntityCopyWith<$Res>? get departamento;$NamedEntityCopyWith<$Res>? get responsavel;$NamedEntityCopyWith<$Res>? get status;$NamedEntityCopyWith<$Res>? get prioridade;

}
/// @nodoc
class _$TaskItemCopyWithImpl<$Res>
    implements $TaskItemCopyWith<$Res> {
  _$TaskItemCopyWithImpl(this._self, this._then);

  final TaskItem _self;
  final $Res Function(TaskItem) _then;

/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titulo = null,Object? descricao = freezed,Object? dataPrazo = freezed,Object? dataConclusao = freezed,Object? dataEntregaReal = freezed,Object? entregueAtrasado = null,Object? totalRetrabalho = null,Object? foiRetrabalho = null,Object? notaExecucao = freezed,Object? aprovadaSemRetrabalho = null,Object? projeto = freezed,Object? departamento = freezed,Object? responsavel = freezed,Object? status = freezed,Object? prioridade = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titulo: null == titulo ? _self.titulo : titulo // ignore: cast_nullable_to_non_nullable
as String,descricao: freezed == descricao ? _self.descricao : descricao // ignore: cast_nullable_to_non_nullable
as String?,dataPrazo: freezed == dataPrazo ? _self.dataPrazo : dataPrazo // ignore: cast_nullable_to_non_nullable
as String?,dataConclusao: freezed == dataConclusao ? _self.dataConclusao : dataConclusao // ignore: cast_nullable_to_non_nullable
as String?,dataEntregaReal: freezed == dataEntregaReal ? _self.dataEntregaReal : dataEntregaReal // ignore: cast_nullable_to_non_nullable
as String?,entregueAtrasado: null == entregueAtrasado ? _self.entregueAtrasado : entregueAtrasado // ignore: cast_nullable_to_non_nullable
as bool,totalRetrabalho: null == totalRetrabalho ? _self.totalRetrabalho : totalRetrabalho // ignore: cast_nullable_to_non_nullable
as int,foiRetrabalho: null == foiRetrabalho ? _self.foiRetrabalho : foiRetrabalho // ignore: cast_nullable_to_non_nullable
as bool,notaExecucao: freezed == notaExecucao ? _self.notaExecucao : notaExecucao // ignore: cast_nullable_to_non_nullable
as String?,aprovadaSemRetrabalho: null == aprovadaSemRetrabalho ? _self.aprovadaSemRetrabalho : aprovadaSemRetrabalho // ignore: cast_nullable_to_non_nullable
as bool,projeto: freezed == projeto ? _self.projeto : projeto // ignore: cast_nullable_to_non_nullable
as NamedEntity?,departamento: freezed == departamento ? _self.departamento : departamento // ignore: cast_nullable_to_non_nullable
as NamedEntity?,responsavel: freezed == responsavel ? _self.responsavel : responsavel // ignore: cast_nullable_to_non_nullable
as NamedEntity?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NamedEntity?,prioridade: freezed == prioridade ? _self.prioridade : prioridade // ignore: cast_nullable_to_non_nullable
as NamedEntity?,
  ));
}
/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get projeto {
    if (_self.projeto == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.projeto!, (value) {
    return _then(_self.copyWith(projeto: value));
  });
}/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get departamento {
    if (_self.departamento == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.departamento!, (value) {
    return _then(_self.copyWith(departamento: value));
  });
}/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get responsavel {
    if (_self.responsavel == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.responsavel!, (value) {
    return _then(_self.copyWith(responsavel: value));
  });
}/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get prioridade {
    if (_self.prioridade == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.prioridade!, (value) {
    return _then(_self.copyWith(prioridade: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskItem].
extension TaskItemPatterns on TaskItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskItem value)  $default,){
final _that = this;
switch (_that) {
case _TaskItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskItem value)?  $default,){
final _that = this;
switch (_that) {
case _TaskItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titulo,  String? descricao, @JsonKey(name: 'data_prazo')  String? dataPrazo, @JsonKey(name: 'data_conclusao')  String? dataConclusao, @JsonKey(name: 'data_entrega_real')  String? dataEntregaReal, @JsonKey(name: 'entregue_atrasado', fromJson: _boolFromJson)  bool entregueAtrasado, @JsonKey(name: 'total_retrabalho')  int totalRetrabalho, @JsonKey(name: 'foi_retrabalho', fromJson: _boolFromJson)  bool foiRetrabalho, @JsonKey(name: 'nota_execucao')  String? notaExecucao, @JsonKey(name: 'aprovada_sem_retrabalho', fromJson: _boolFromJson)  bool aprovadaSemRetrabalho, @JsonKey(fromJson: _entityFromJson)  NamedEntity? projeto, @JsonKey(fromJson: _entityFromJson)  NamedEntity? departamento, @JsonKey(fromJson: _entityFromJson)  NamedEntity? responsavel, @JsonKey(fromJson: _entityFromJson)  NamedEntity? status, @JsonKey(fromJson: _entityFromJson)  NamedEntity? prioridade)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskItem() when $default != null:
return $default(_that.id,_that.titulo,_that.descricao,_that.dataPrazo,_that.dataConclusao,_that.dataEntregaReal,_that.entregueAtrasado,_that.totalRetrabalho,_that.foiRetrabalho,_that.notaExecucao,_that.aprovadaSemRetrabalho,_that.projeto,_that.departamento,_that.responsavel,_that.status,_that.prioridade);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titulo,  String? descricao, @JsonKey(name: 'data_prazo')  String? dataPrazo, @JsonKey(name: 'data_conclusao')  String? dataConclusao, @JsonKey(name: 'data_entrega_real')  String? dataEntregaReal, @JsonKey(name: 'entregue_atrasado', fromJson: _boolFromJson)  bool entregueAtrasado, @JsonKey(name: 'total_retrabalho')  int totalRetrabalho, @JsonKey(name: 'foi_retrabalho', fromJson: _boolFromJson)  bool foiRetrabalho, @JsonKey(name: 'nota_execucao')  String? notaExecucao, @JsonKey(name: 'aprovada_sem_retrabalho', fromJson: _boolFromJson)  bool aprovadaSemRetrabalho, @JsonKey(fromJson: _entityFromJson)  NamedEntity? projeto, @JsonKey(fromJson: _entityFromJson)  NamedEntity? departamento, @JsonKey(fromJson: _entityFromJson)  NamedEntity? responsavel, @JsonKey(fromJson: _entityFromJson)  NamedEntity? status, @JsonKey(fromJson: _entityFromJson)  NamedEntity? prioridade)  $default,) {final _that = this;
switch (_that) {
case _TaskItem():
return $default(_that.id,_that.titulo,_that.descricao,_that.dataPrazo,_that.dataConclusao,_that.dataEntregaReal,_that.entregueAtrasado,_that.totalRetrabalho,_that.foiRetrabalho,_that.notaExecucao,_that.aprovadaSemRetrabalho,_that.projeto,_that.departamento,_that.responsavel,_that.status,_that.prioridade);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titulo,  String? descricao, @JsonKey(name: 'data_prazo')  String? dataPrazo, @JsonKey(name: 'data_conclusao')  String? dataConclusao, @JsonKey(name: 'data_entrega_real')  String? dataEntregaReal, @JsonKey(name: 'entregue_atrasado', fromJson: _boolFromJson)  bool entregueAtrasado, @JsonKey(name: 'total_retrabalho')  int totalRetrabalho, @JsonKey(name: 'foi_retrabalho', fromJson: _boolFromJson)  bool foiRetrabalho, @JsonKey(name: 'nota_execucao')  String? notaExecucao, @JsonKey(name: 'aprovada_sem_retrabalho', fromJson: _boolFromJson)  bool aprovadaSemRetrabalho, @JsonKey(fromJson: _entityFromJson)  NamedEntity? projeto, @JsonKey(fromJson: _entityFromJson)  NamedEntity? departamento, @JsonKey(fromJson: _entityFromJson)  NamedEntity? responsavel, @JsonKey(fromJson: _entityFromJson)  NamedEntity? status, @JsonKey(fromJson: _entityFromJson)  NamedEntity? prioridade)?  $default,) {final _that = this;
switch (_that) {
case _TaskItem() when $default != null:
return $default(_that.id,_that.titulo,_that.descricao,_that.dataPrazo,_that.dataConclusao,_that.dataEntregaReal,_that.entregueAtrasado,_that.totalRetrabalho,_that.foiRetrabalho,_that.notaExecucao,_that.aprovadaSemRetrabalho,_that.projeto,_that.departamento,_that.responsavel,_that.status,_that.prioridade);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskItem implements TaskItem {
  const _TaskItem({required this.id, required this.titulo, this.descricao, @JsonKey(name: 'data_prazo') this.dataPrazo, @JsonKey(name: 'data_conclusao') this.dataConclusao, @JsonKey(name: 'data_entrega_real') this.dataEntregaReal, @JsonKey(name: 'entregue_atrasado', fromJson: _boolFromJson) this.entregueAtrasado = false, @JsonKey(name: 'total_retrabalho') this.totalRetrabalho = 0, @JsonKey(name: 'foi_retrabalho', fromJson: _boolFromJson) this.foiRetrabalho = false, @JsonKey(name: 'nota_execucao') this.notaExecucao, @JsonKey(name: 'aprovada_sem_retrabalho', fromJson: _boolFromJson) this.aprovadaSemRetrabalho = false, @JsonKey(fromJson: _entityFromJson) this.projeto, @JsonKey(fromJson: _entityFromJson) this.departamento, @JsonKey(fromJson: _entityFromJson) this.responsavel, @JsonKey(fromJson: _entityFromJson) this.status, @JsonKey(fromJson: _entityFromJson) this.prioridade});
  factory _TaskItem.fromJson(Map<String, dynamic> json) => _$TaskItemFromJson(json);

@override final  int id;
@override final  String titulo;
@override final  String? descricao;
@override@JsonKey(name: 'data_prazo') final  String? dataPrazo;
@override@JsonKey(name: 'data_conclusao') final  String? dataConclusao;
@override@JsonKey(name: 'data_entrega_real') final  String? dataEntregaReal;
@override@JsonKey(name: 'entregue_atrasado', fromJson: _boolFromJson) final  bool entregueAtrasado;
@override@JsonKey(name: 'total_retrabalho') final  int totalRetrabalho;
@override@JsonKey(name: 'foi_retrabalho', fromJson: _boolFromJson) final  bool foiRetrabalho;
@override@JsonKey(name: 'nota_execucao') final  String? notaExecucao;
@override@JsonKey(name: 'aprovada_sem_retrabalho', fromJson: _boolFromJson) final  bool aprovadaSemRetrabalho;
@override@JsonKey(fromJson: _entityFromJson) final  NamedEntity? projeto;
@override@JsonKey(fromJson: _entityFromJson) final  NamedEntity? departamento;
@override@JsonKey(fromJson: _entityFromJson) final  NamedEntity? responsavel;
@override@JsonKey(fromJson: _entityFromJson) final  NamedEntity? status;
@override@JsonKey(fromJson: _entityFromJson) final  NamedEntity? prioridade;

/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskItemCopyWith<_TaskItem> get copyWith => __$TaskItemCopyWithImpl<_TaskItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskItem&&(identical(other.id, id) || other.id == id)&&(identical(other.titulo, titulo) || other.titulo == titulo)&&(identical(other.descricao, descricao) || other.descricao == descricao)&&(identical(other.dataPrazo, dataPrazo) || other.dataPrazo == dataPrazo)&&(identical(other.dataConclusao, dataConclusao) || other.dataConclusao == dataConclusao)&&(identical(other.dataEntregaReal, dataEntregaReal) || other.dataEntregaReal == dataEntregaReal)&&(identical(other.entregueAtrasado, entregueAtrasado) || other.entregueAtrasado == entregueAtrasado)&&(identical(other.totalRetrabalho, totalRetrabalho) || other.totalRetrabalho == totalRetrabalho)&&(identical(other.foiRetrabalho, foiRetrabalho) || other.foiRetrabalho == foiRetrabalho)&&(identical(other.notaExecucao, notaExecucao) || other.notaExecucao == notaExecucao)&&(identical(other.aprovadaSemRetrabalho, aprovadaSemRetrabalho) || other.aprovadaSemRetrabalho == aprovadaSemRetrabalho)&&(identical(other.projeto, projeto) || other.projeto == projeto)&&(identical(other.departamento, departamento) || other.departamento == departamento)&&(identical(other.responsavel, responsavel) || other.responsavel == responsavel)&&(identical(other.status, status) || other.status == status)&&(identical(other.prioridade, prioridade) || other.prioridade == prioridade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titulo,descricao,dataPrazo,dataConclusao,dataEntregaReal,entregueAtrasado,totalRetrabalho,foiRetrabalho,notaExecucao,aprovadaSemRetrabalho,projeto,departamento,responsavel,status,prioridade);

@override
String toString() {
  return 'TaskItem(id: $id, titulo: $titulo, descricao: $descricao, dataPrazo: $dataPrazo, dataConclusao: $dataConclusao, dataEntregaReal: $dataEntregaReal, entregueAtrasado: $entregueAtrasado, totalRetrabalho: $totalRetrabalho, foiRetrabalho: $foiRetrabalho, notaExecucao: $notaExecucao, aprovadaSemRetrabalho: $aprovadaSemRetrabalho, projeto: $projeto, departamento: $departamento, responsavel: $responsavel, status: $status, prioridade: $prioridade)';
}


}

/// @nodoc
abstract mixin class _$TaskItemCopyWith<$Res> implements $TaskItemCopyWith<$Res> {
  factory _$TaskItemCopyWith(_TaskItem value, $Res Function(_TaskItem) _then) = __$TaskItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String titulo, String? descricao,@JsonKey(name: 'data_prazo') String? dataPrazo,@JsonKey(name: 'data_conclusao') String? dataConclusao,@JsonKey(name: 'data_entrega_real') String? dataEntregaReal,@JsonKey(name: 'entregue_atrasado', fromJson: _boolFromJson) bool entregueAtrasado,@JsonKey(name: 'total_retrabalho') int totalRetrabalho,@JsonKey(name: 'foi_retrabalho', fromJson: _boolFromJson) bool foiRetrabalho,@JsonKey(name: 'nota_execucao') String? notaExecucao,@JsonKey(name: 'aprovada_sem_retrabalho', fromJson: _boolFromJson) bool aprovadaSemRetrabalho,@JsonKey(fromJson: _entityFromJson) NamedEntity? projeto,@JsonKey(fromJson: _entityFromJson) NamedEntity? departamento,@JsonKey(fromJson: _entityFromJson) NamedEntity? responsavel,@JsonKey(fromJson: _entityFromJson) NamedEntity? status,@JsonKey(fromJson: _entityFromJson) NamedEntity? prioridade
});


@override $NamedEntityCopyWith<$Res>? get projeto;@override $NamedEntityCopyWith<$Res>? get departamento;@override $NamedEntityCopyWith<$Res>? get responsavel;@override $NamedEntityCopyWith<$Res>? get status;@override $NamedEntityCopyWith<$Res>? get prioridade;

}
/// @nodoc
class __$TaskItemCopyWithImpl<$Res>
    implements _$TaskItemCopyWith<$Res> {
  __$TaskItemCopyWithImpl(this._self, this._then);

  final _TaskItem _self;
  final $Res Function(_TaskItem) _then;

/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titulo = null,Object? descricao = freezed,Object? dataPrazo = freezed,Object? dataConclusao = freezed,Object? dataEntregaReal = freezed,Object? entregueAtrasado = null,Object? totalRetrabalho = null,Object? foiRetrabalho = null,Object? notaExecucao = freezed,Object? aprovadaSemRetrabalho = null,Object? projeto = freezed,Object? departamento = freezed,Object? responsavel = freezed,Object? status = freezed,Object? prioridade = freezed,}) {
  return _then(_TaskItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titulo: null == titulo ? _self.titulo : titulo // ignore: cast_nullable_to_non_nullable
as String,descricao: freezed == descricao ? _self.descricao : descricao // ignore: cast_nullable_to_non_nullable
as String?,dataPrazo: freezed == dataPrazo ? _self.dataPrazo : dataPrazo // ignore: cast_nullable_to_non_nullable
as String?,dataConclusao: freezed == dataConclusao ? _self.dataConclusao : dataConclusao // ignore: cast_nullable_to_non_nullable
as String?,dataEntregaReal: freezed == dataEntregaReal ? _self.dataEntregaReal : dataEntregaReal // ignore: cast_nullable_to_non_nullable
as String?,entregueAtrasado: null == entregueAtrasado ? _self.entregueAtrasado : entregueAtrasado // ignore: cast_nullable_to_non_nullable
as bool,totalRetrabalho: null == totalRetrabalho ? _self.totalRetrabalho : totalRetrabalho // ignore: cast_nullable_to_non_nullable
as int,foiRetrabalho: null == foiRetrabalho ? _self.foiRetrabalho : foiRetrabalho // ignore: cast_nullable_to_non_nullable
as bool,notaExecucao: freezed == notaExecucao ? _self.notaExecucao : notaExecucao // ignore: cast_nullable_to_non_nullable
as String?,aprovadaSemRetrabalho: null == aprovadaSemRetrabalho ? _self.aprovadaSemRetrabalho : aprovadaSemRetrabalho // ignore: cast_nullable_to_non_nullable
as bool,projeto: freezed == projeto ? _self.projeto : projeto // ignore: cast_nullable_to_non_nullable
as NamedEntity?,departamento: freezed == departamento ? _self.departamento : departamento // ignore: cast_nullable_to_non_nullable
as NamedEntity?,responsavel: freezed == responsavel ? _self.responsavel : responsavel // ignore: cast_nullable_to_non_nullable
as NamedEntity?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NamedEntity?,prioridade: freezed == prioridade ? _self.prioridade : prioridade // ignore: cast_nullable_to_non_nullable
as NamedEntity?,
  ));
}

/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get projeto {
    if (_self.projeto == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.projeto!, (value) {
    return _then(_self.copyWith(projeto: value));
  });
}/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get departamento {
    if (_self.departamento == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.departamento!, (value) {
    return _then(_self.copyWith(departamento: value));
  });
}/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get responsavel {
    if (_self.responsavel == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.responsavel!, (value) {
    return _then(_self.copyWith(responsavel: value));
  });
}/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of TaskItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedEntityCopyWith<$Res>? get prioridade {
    if (_self.prioridade == null) {
    return null;
  }

  return $NamedEntityCopyWith<$Res>(_self.prioridade!, (value) {
    return _then(_self.copyWith(prioridade: value));
  });
}
}

// dart format on
