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
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "kycStatus")
  String? kycStatus;
  @JsonKey(name: "bookmarks")
  List<String>? bookmarks;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "role")
  String? role;

  UserModel({
    this.uid,
    this.name,
    this.phone,
    this.email,
    this.token,
    this.kycStatus,
    this.bookmarks,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
