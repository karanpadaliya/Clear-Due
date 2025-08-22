// To parse this JSON data, do
//
//     final retailerDetailsRequestModel = retailerDetailsRequestModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'retailer_details_request_model.g.dart';

RetailerDetailsRequestModel retailerDetailsRequestModelFromJson(String str) =>
    RetailerDetailsRequestModel.fromJson(json.decode(str));

String retailerDetailsRequestModelToJson(RetailerDetailsRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class RetailerDetailsRequestModel {
  @JsonKey(name: "getRetailerDetailsNew")
  String? getRetailerDetailsNew;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "retailer_id")
  String? retailerId;
  @JsonKey(name: "isByPass")
  String? isByPass;
  @JsonKey(name: "society_id")
  String? societyId;
  @JsonKey(name: "startVisitId")
  String? startVisitId;
  @JsonKey(name: "third_party_contact_number")
  String? thirdPartyContactNumber;
  @JsonKey(name: "retailer_external_data")
  String? retailerExternalData;

  RetailerDetailsRequestModel({
    this.getRetailerDetailsNew,
    this.userId,
    this.retailerId,
    this.isByPass,
    this.societyId,
    this.startVisitId,
    this.thirdPartyContactNumber,
    this.retailerExternalData,
  });

  factory RetailerDetailsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RetailerDetailsRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetailerDetailsRequestModelToJson(this);
}
