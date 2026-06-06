// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      message: json['message'] as String?,
      token: json['token'] as String,
      tokenType: json['token_type'] as String,
      user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'token_type': instance.tokenType,
      'user': instance.user,
    };

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  isAdmin: json['is_admin'] as bool? ?? false,
  isActive: json['is_active'] as bool? ?? true,
  usuario: json['usuario'] == null
      ? null
      : UserProfile.fromJson(json['usuario'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'is_admin': instance.isAdmin,
  'is_active': instance.isActive,
  'usuario': instance.usuario,
};

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: (json['id'] as num).toInt(),
  nome: json['nome'] as String,
  cargo: json['cargo'] == null
      ? null
      : NamedEntity.fromJson(json['cargo'] as Map<String, dynamic>),
  departamento: json['departamento'] == null
      ? null
      : NamedEntity.fromJson(json['departamento'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'cargo': instance.cargo,
      'departamento': instance.departamento,
    };

_NamedEntity _$NamedEntityFromJson(Map<String, dynamic> json) =>
    _NamedEntity(id: (json['id'] as num).toInt(), nome: json['nome'] as String);

Map<String, dynamic> _$NamedEntityToJson(_NamedEntity instance) =>
    <String, dynamic>{'id': instance.id, 'nome': instance.nome};
