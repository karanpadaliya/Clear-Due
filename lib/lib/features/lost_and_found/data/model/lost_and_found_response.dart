import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/lost_and_found/domain/entities/lost_and_found_entity.dart';

part 'lost_and_found_response.g.dart';

LostAndFoundResponseModel lostAndFoundResponseModelFromJson(String str) =>
    LostAndFoundResponseModel.fromJson(json.decode(str));

@JsonSerializable(explicitToJson: true)
class LostAndFoundResponseModel {
  @JsonKey(name: 'lostfound')
  final List<LostFoundModel>? lostFound;
  @JsonKey(name: 'message')
  final String? message;

  LostAndFoundResponseModel({this.lostFound, this.message});

  factory LostAndFoundResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LostAndFoundResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LostAndFoundResponseModelToJson(this);

  /// Converts to domain entity
  LostAndFoundEntity toEntity() => LostAndFoundEntity(
    lostFoundItems: lostFound?.map((e) => e.toEntity()).toList(),
    message: message,
  );
}

@JsonSerializable()
class LostFoundModel {
  @JsonKey(name: 'lost_found_master_id')
  final String? lostFoundMasterId;
  @JsonKey(name: 'society_id')
  final String? societyId;
  @JsonKey(name: 'unit_id')
  final String? unitId;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'is_user')
  final bool? isUser;
  @JsonKey(name: 'is_chat')
  final bool? isChat;
  @JsonKey(name: 'lost_found_title')
  final String? lostFoundTitle;
  @JsonKey(name: 'lost_found_description')
  final String? lostFoundDescription;
  @JsonKey(name: 'lost_found_date')
  final String? lostFoundDate;
  @JsonKey(name: 'complain_assing_to')
  final String? complainAssingTo;
  @JsonKey(name: 'block_name')
  final String? blockName;
  @JsonKey(name: 'branch_name')
  final String? branchName;
  @JsonKey(name: 'department_name')
  final String? departmentName;
  @JsonKey(name: 'user_designation')
  final String? userDesignation;
  @JsonKey(name: 'user_full_name')
  final String? userFullName;
  @JsonKey(name: 'user_mobile')
  final String? userMobile;
  @JsonKey(name: 'country_code')
  final String? countryCode;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'user_token')
  final String? userToken;
  @JsonKey(name: 'lost_found_image')
  final String? lostFoundImage;
  @JsonKey(name: 'lost_found_type')
  final String? lostFoundType;
  @JsonKey(name: 'lost_found_type_int')
  final String? lostFoundTypeInt;
  @JsonKey(name: 'user_profile_pic')
  final String? userProfilePic;
  @JsonKey(name: 'tenant_view')
  final String? tenantView;
  @JsonKey(name: 'public_mobile')
  final String? publicMobile;
  @JsonKey(name: 'user_type')
  final String? userType;

  const LostFoundModel({
    this.lostFoundMasterId,
    this.societyId,
    this.unitId,
    this.userId,
    this.isUser,
    this.isChat,
    this.lostFoundTitle,
    this.lostFoundDescription,
    this.lostFoundDate,
    this.complainAssingTo,
    this.blockName,
    this.branchName,
    this.departmentName,
    this.userDesignation,
    this.userFullName,
    this.userMobile,
    this.countryCode,
    this.gender,
    this.userToken,
    this.lostFoundImage,
    this.lostFoundType,
    this.lostFoundTypeInt,
    this.userProfilePic,
    this.tenantView,
    this.publicMobile,
    this.userType,
  });

  factory LostFoundModel.fromJson(Map<String, dynamic> json) =>
      _$LostFoundModelFromJson(json);

  Map<String, dynamic> toJson() => _$LostFoundModelToJson(this);

  /// Converts to domain entity
  LostFoundEntity toEntity() => LostFoundEntity(
    lostFoundMasterId: lostFoundMasterId,
    societyId: societyId,
    unitId: unitId,
    userId: userId,
    isUser: isUser,
    isChat: isChat,
    lostFoundTitle: lostFoundTitle,
    lostFoundDescription: lostFoundDescription,
    lostFoundDate: lostFoundDate,
    complainAssingTo: complainAssingTo,
    blockName: blockName,
    branchName: branchName,
    departmentName: departmentName,
    userDesignation: userDesignation,
    userFullName: userFullName,
    userMobile: userMobile,
    countryCode: countryCode,
    gender: gender,
    userToken: userToken,
    lostFoundImage: lostFoundImage,
    lostFoundType: lostFoundType,
    lostFoundTypeInt: lostFoundTypeInt,
    userProfilePic: userProfilePic,
    tenantView: tenantView,
    publicMobile: publicMobile,
    userType: userType,
  );
}
