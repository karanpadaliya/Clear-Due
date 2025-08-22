// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_asset_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAssetUserModel _$AddAssetUserModelFromJson(Map<String, dynamic> json) =>
    AddAssetUserModel(
      employees:
          (json['employees'] as List<dynamic>?)
              ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
              .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AddAssetUserModelToJson(AddAssetUserModel instance) =>
    <String, dynamic>{
      'employees': instance.employees,
      'message': instance.message,
    };

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
  userId: json['user_id'] as String?,
  blockId: json['block_id'] as String?,
  floorId: json['floor_id'] as String?,
  userFirstName: json['user_first_name'] as String?,
  userLastName: json['user_last_name'] as String?,
  userMobile: json['user_mobile'] as String?,
  userFullName: json['user_full_name'] as String?,
  societyId: json['society_id'] as String?,
  designation: json['designation'] as String?,
  shortName: json['short_name'] as String?,
  userProfilePic: json['user_profile_pic'] as String?,
);

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
  'user_id': instance.userId,
  'block_id': instance.blockId,
  'floor_id': instance.floorId,
  'user_first_name': instance.userFirstName,
  'user_last_name': instance.userLastName,
  'user_mobile': instance.userMobile,
  'user_full_name': instance.userFullName,
  'society_id': instance.societyId,
  'designation': instance.designation,
  'short_name': instance.shortName,
  'user_profile_pic': instance.userProfilePic,
};
