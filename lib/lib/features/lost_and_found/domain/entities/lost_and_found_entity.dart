import 'package:equatable/equatable.dart';

/// Domain entity representing a single Lost & Found item.
class LostFoundEntity extends Equatable {
  final String? lostFoundMasterId;
  final String? societyId;
  final String? unitId;
  final String? userId;
  final bool? isUser;
  final bool? isChat;
  final String? lostFoundTitle;
  final String? lostFoundDescription;
  final String? lostFoundDate;
  final String? complainAssingTo;
  final String? blockName;
  final String? branchName;
  final String? departmentName;
  final String? userDesignation;
  final String? userFullName;
  final String? userMobile;
  final String? countryCode;
  final String? gender;
  final String? userToken;
  final String? lostFoundImage;
  final String? lostFoundType;
  final String? lostFoundTypeInt;
  final String? userProfilePic;
  final String? tenantView;
  final String? publicMobile;
  final String? userType;

  const LostFoundEntity({
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

  @override
  List<Object?> get props => [
    lostFoundMasterId,
    societyId,
    unitId,
    userId,
    isUser,
    isChat,
    lostFoundTitle,
    lostFoundDescription,
    lostFoundDate,
    complainAssingTo,
    blockName,
    branchName,
    departmentName,
    userDesignation,
    userFullName,
    userMobile,
    countryCode,
    gender,
    userToken,
    lostFoundImage,
    lostFoundType,
    lostFoundTypeInt,
    userProfilePic,
    tenantView,
    publicMobile,
    userType,
  ];
}

/// Domain entity representing the full Lost & Found API response.
class LostAndFoundEntity extends Equatable {
  final List<LostFoundEntity>? lostFoundItems;
  final String? message;

  const LostAndFoundEntity({
    this.lostFoundItems,
    this.message,
  });

  @override
  List<Object?> get props => [lostFoundItems, message];
}
