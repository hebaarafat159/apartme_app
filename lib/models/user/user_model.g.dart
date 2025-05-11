// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String?,
      image: json['image_path'] as String?,
      googleToken: json['google_token'] as String?,
      token: json['token'] as String?,
      lastLogin: _$JsonConverterFromJson<Timestamp, Timestamp>(
          json['last_login'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      if (instance.password case final value?) 'password': value,
      'phone': instance.phone,
      if (instance.image case final value?) 'image_path': value,
      if (instance.googleToken case final value?) 'google_token': value,
      if (instance.token case final value?) 'token': value,
      'last_login': _$JsonConverterToJson<Timestamp, Timestamp>(
          instance.lastLogin, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
