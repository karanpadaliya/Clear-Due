// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  uid: json['uid'] as String?,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  role: json['role'] as String?,
  referredBy: json['referredBy'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'uid': instance.uid,
  'name': instance.name,
  'phone': instance.phone,
  'email': instance.email,
  'role': instance.role,
  'referredBy': instance.referredBy,
  'createdAt': instance.createdAt?.toIso8601String(),
};
