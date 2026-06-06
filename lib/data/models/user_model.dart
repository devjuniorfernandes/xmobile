import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    String? message,
    required String token,
    @JsonKey(name: 'token_type') required String tokenType,
    required AppUser user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required int id,
    required String name,
    required String email,
    @JsonKey(name: 'is_admin') @Default(false) bool isAdmin,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    UserProfile? usuario,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String nome,
    NamedEntity? cargo,
    NamedEntity? departamento,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
abstract class NamedEntity with _$NamedEntity {
  const factory NamedEntity({required int id, required String nome}) =
      _NamedEntity;

  factory NamedEntity.fromJson(Map<String, dynamic> json) =>
      _$NamedEntityFromJson(json);
}
