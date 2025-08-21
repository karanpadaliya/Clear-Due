import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserModel {
  @JsonKey(name: "uid")
  String? uid;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "referredBy")
  String? referredBy;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  UserModel({
    this.uid,
    this.name,
    this.phone,
    this.email,
    this.role,
    this.referredBy,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}