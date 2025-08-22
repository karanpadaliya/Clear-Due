// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lost_and_found_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LostAndFoundResponseModel _$LostAndFoundResponseModelFromJson(
  Map<String, dynamic> json,
) => LostAndFoundResponseModel(
  lostFound:
      (json['lostfound'] as List<dynamic>?)
          ?.map((e) => LostFoundModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$LostAndFoundResponseModelToJson(
  LostAndFoundResponseModel instance,
) => <String, dynamic>{
  'lostfound': instance.lostFound?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

LostFoundModel _$LostFoundModelFromJson(Map<String, dynamic> json) =>
    LostFoundModel(
      lostFoundMasterId: json['lost_found_master_id'] as String?,
      societyId: json['society_id'] as String?,
      unitId: json['unit_id'] as String?,
      userId: json['user_id'] as String?,
      isUser: json['is_user'] as bool?,
      isChat: json['is_chat'] as bool?,
      lostFoundTitle: json['lost_found_title'] as String?,
      lostFoundDescription: json['lost_found_description'] as String?,
      lostFoundDate: json['lost_found_date'] as String?,
      complainAssingTo: json['complain_assing_to'] as String?,
      blockName: json['block_name'] as String?,
      branchName: json['branch_name'] as String?,
      departmentName: json['department_name'] as String?,
      userDesignation: json['user_designation'] as String?,
      userFullName: json['user_full_name'] as String?,
      userMobile: json['user_mobile'] as String?,
      countryCode: json['country_code'] as String?,
      gender: json['gender'] as String?,
      userToken: json['user_token'] as String?,
      lostFoundImage: json['lost_found_image'] as String?,
      lostFoundType: json['lost_found_type'] as String?,
      lostFoundTypeInt: json['lost_found_type_int'] as String?,
      userProfilePic: json['user_profile_pic'] as String?,
      tenantView: json['tenant_view'] as String?,
      publicMobile: json['public_mobile'] as String?,
      userType: json['user_type'] as String?,
    );

Map<String, dynamic> _$LostFoundModelToJson(LostFoundModel instance) =>
    <String, dynamic>{
      'lost_found_master_id': instance.lostFoundMasterId,
      'society_id': instance.societyId,
      'unit_id': instance.unitId,
      'user_id': instance.userId,
      'is_user': instance.isUser,
      'is_chat': instance.isChat,
      'lost_found_title': instance.lostFoundTitle,
      'lost_found_description': instance.lostFoundDescription,
      'lost_found_date': instance.lostFoundDate,
      'complain_assing_to': instance.complainAssingTo,
      'block_name': instance.blockName,
      'branch_name': instance.branchName,
      'department_name': instance.departmentName,
      'user_designation': instance.userDesignation,
      'user_full_name': instance.userFullName,
      'user_mobile': instance.userMobile,
      'country_code': instance.countryCode,
      'gender': instance.gender,
      'user_token': instance.userToken,
      'lost_found_image': instance.lostFoundImage,
      'lost_found_type': instance.lostFoundType,
      'lost_found_type_int': instance.lostFoundTypeInt,
      'user_profile_pic': instance.userProfilePic,
      'tenant_view': instance.tenantView,
      'public_mobile': instance.publicMobile,
      'user_type': instance.userType,
    };
