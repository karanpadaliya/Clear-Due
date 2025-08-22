// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailer_details_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetailerDetailsRequestModel _$RetailerDetailsRequestModelFromJson(
  Map<String, dynamic> json,
) => RetailerDetailsRequestModel(
  getRetailerDetailsNew: json['getRetailerDetailsNew'] as String?,
  userId: json['user_id'] as String?,
  retailerId: json['retailer_id'] as String?,
  isByPass: json['isByPass'] as String?,
  societyId: json['society_id'] as String?,
  startVisitId: json['startVisitId'] as String?,
  thirdPartyContactNumber: json['third_party_contact_number'] as String?,
  retailerExternalData: json['retailer_external_data'] as String?,
);

Map<String, dynamic> _$RetailerDetailsRequestModelToJson(
  RetailerDetailsRequestModel instance,
) => <String, dynamic>{
  'getRetailerDetailsNew': instance.getRetailerDetailsNew,
  'user_id': instance.userId,
  'retailer_id': instance.retailerId,
  'isByPass': instance.isByPass,
  'society_id': instance.societyId,
  'startVisitId': instance.startVisitId,
  'third_party_contact_number': instance.thirdPartyContactNumber,
  'retailer_external_data': instance.retailerExternalData,
};
