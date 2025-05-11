import 'package:apartme/db/db_user_helper.dart';
import 'package:apartme/models/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: DbUserHelper.DB_USER_TABLE_ID_KEY)
  String? uid;

  @JsonKey(name: DbUserHelper.DB_USER_TABLE_NAME_KEY)
  final String name;

  @JsonKey(name: DbUserHelper.DB_USER_TABLE_EMAIL_KEY)
  final String email;

  @JsonKey(name: DbUserHelper.DB_USER_TABLE_PASSWORD_KEY, includeIfNull: false)
  final String? password;

  @JsonKey(name: DbUserHelper.DB_USER_TABLE_PHONE_KEY)
  final String phone;

  @JsonKey(name: DbUserHelper.DB_USER_TABLE_IMAGE_KEY, includeIfNull: false)
  final String? image;

  @JsonKey(
      name: DbUserHelper.DB_USER_TABLE_GOOGLE_TOKEN_KEY, includeIfNull: false)
  final String? googleToken;

  @JsonKey(name: DbUserHelper.DB_USER_TABLE_TOKEN_KEY, includeIfNull: false)
  final String? token;

  @JsonKey(name: DbUserHelper.DB_USER_TABLE_LAST_LIGIN_KEY)
  @TimestampConverter()
  Timestamp? lastLogin;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.password,
    this.image,
    this.googleToken,
    this.token,
    this.lastLogin,
  });

  /// Factory constructor to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Method to convert instance to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
