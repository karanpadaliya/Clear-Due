// To parse this JSON data, do
//
//     final retailerDetailsModel = retailerDetailsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:myco_flutter/features/take_order/domain/entities/retailer_details_entity.dart';

part 'retailer_details_model.g.dart';

RetailerDetailsModel retailerDetailsModelFromJson(String str) =>
    RetailerDetailsModel.fromJson(json.decode(str));

String retailerDetailsModelToJson(RetailerDetailsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class RetailerDetailsModel {
  @JsonKey(name: 'apply_gst_on_order')
  String? applyGstOnOrder;
  @JsonKey(name: 'apply_fraight_in_take_order')
  String? applyFraightInTakeOrder;
  @JsonKey(name: 'company_state_id')
  String? companyStateId;
  @JsonKey(name: 'edit_customer_detail')
  bool? editCustomerDetail;
  @JsonKey(name: 'start_visit_with_otp')
  bool? startVisitWithOtp;
  @JsonKey(name: 'retailer_id')
  String? retailerId;
  @JsonKey(name: 'route_id')
  dynamic routeId;
  @JsonKey(name: 'retailer_daily_visit_timeline_id')
  String? retailerDailyVisitTimelineId;
  @JsonKey(name: 'retailer_visit_start_datetime')
  String? retailerVisitStartDatetime;
  @JsonKey(name: 'retailer_visit_end_datetime')
  String? retailerVisitEndDatetime;
  @JsonKey(name: 'route_name')
  dynamic routeName;
  @JsonKey(name: 'route_name_code')
  String? routeNameCode;
  @JsonKey(name: 'society_id')
  String? societyId;
  @JsonKey(name: 'country_id')
  String? countryId;
  @JsonKey(name: 'country_name')
  String? countryName;
  @JsonKey(name: 'customer_category_id')
  String? customerCategoryId;
  @JsonKey(name: 'customer_category_name')
  String? customerCategoryName;
  @JsonKey(name: 'customer_sub_category_id')
  String? customerSubCategoryId;
  @JsonKey(name: 'customer_sub_category_name')
  String? customerSubCategoryName;
  @JsonKey(name: 'state_id')
  String? stateId;
  @JsonKey(name: 'state_name')
  String? stateName;
  @JsonKey(name: 'city_id')
  String? cityId;
  @JsonKey(name: 'city_name')
  String? cityName;
  @JsonKey(name: 'super_distributor_name')
  String? superDistributorName;
  @JsonKey(name: 'area_name')
  String? areaName;
  @JsonKey(name: 'retailer_name')
  String? retailerName;
  @JsonKey(name: 'retailer_code')
  String? retailerCode;
  @JsonKey(name: 'retailer_contact_person')
  String? retailerContactPerson;
  @JsonKey(name: 'retailer_contact_person_number')
  String? retailerContactPersonNumber;
  @JsonKey(name: 'retailer_alt_contact_number')
  String? retailerAltContactNumber;
  @JsonKey(name: 'retailer_contact_person_country_code')
  String? retailerContactPersonCountryCode;
  @JsonKey(name: 'retailer_contact_person_number_with_country_code')
  String? retailerContactPersonNumberWithCountryCode;
  @JsonKey(name: 'retailer_alt_country_code')
  String? retailerAltCountryCode;
  @JsonKey(name: 'retailer_address')
  String? retailerAddress;
  @JsonKey(name: 'retailer_google_address')
  String? retailerGoogleAddress;
  @JsonKey(name: 'retailer_latitude')
  String? retailerLatitude;
  @JsonKey(name: 'retailer_longitude')
  String? retailerLongitude;
  @JsonKey(name: 'retailer_created_by')
  String? retailerCreatedBy;
  @JsonKey(name: 'retailer_geofence_range')
  String? retailerGeofenceRange;
  @JsonKey(name: 'retailer_pincode')
  String? retailerPincode;
  @JsonKey(name: 'retailer_gst_no')
  String? retailerGstNo;
  @JsonKey(name: 'retailer_type')
  String? retailerType;
  @JsonKey(name: 'retailer_credit_limit')
  String? retailerCreditLimit;
  @JsonKey(name: 'retailer_credit_days')
  String? retailerCreditDays;
  @JsonKey(name: 'retailer_remark')
  String? retailerRemark;
  @JsonKey(name: 'retailer_photo_name')
  String? retailerPhotoName;
  @JsonKey(name: 'retailer_email')
  String? retailerEmail;
  @JsonKey(name: 'retailer_website')
  String? retailerWebsite;
  @JsonKey(name: 'retailer_date_of_birth')
  String? retailerDateOfBirth;
  @JsonKey(name: 'retailer_wedding_anniversary_date')
  String? retailerWeddingAnniversaryDate;
  @JsonKey(name: 'area_id')
  String? areaId;
  @JsonKey(name: 'retailer_last_distributor_id')
  String? retailerLastDistributorId;
  @JsonKey(name: 'retailer_last_visit_by')
  String? retailerLastVisitBy;
  @JsonKey(name: 'retailer_last_visit_by_name')
  String? retailerLastVisitByName;
  @JsonKey(name: 'retailer_photo')
  String? retailerPhoto;
  @JsonKey(name: 'retailer_verified')
  bool? retailerVerified;
  @JsonKey(name: 'retailer_last_order_date')
  String? retailerLastOrderDate;
  @JsonKey(name: 'retailer_last_visit_date')
  String? retailerLastVisitDate;
  @JsonKey(name: 'retailer_last_order_amount')
  String? retailerLastOrderAmount;
  @JsonKey(name: 'retailer_created_date')
  String? retailerCreatedDate;
  @JsonKey(name: 'total_distributors')
  String? totalDistributors;
  @JsonKey(name: 'distributors')
  List<Distributor>? distributors;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'status')
  String? status;

  RetailerDetailsModel({
    this.applyGstOnOrder,
    this.applyFraightInTakeOrder,
    this.companyStateId,
    this.editCustomerDetail,
    this.startVisitWithOtp,
    this.retailerId,
    this.routeId,
    this.retailerDailyVisitTimelineId,
    this.retailerVisitStartDatetime,
    this.retailerVisitEndDatetime,
    this.routeName,
    this.routeNameCode,
    this.societyId,
    this.countryId,
    this.countryName,
    this.customerCategoryId,
    this.customerCategoryName,
    this.customerSubCategoryId,
    this.customerSubCategoryName,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.superDistributorName,
    this.areaName,
    this.retailerName,
    this.retailerCode,
    this.retailerContactPerson,
    this.retailerContactPersonNumber,
    this.retailerAltContactNumber,
    this.retailerContactPersonCountryCode,
    this.retailerContactPersonNumberWithCountryCode,
    this.retailerAltCountryCode,
    this.retailerAddress,
    this.retailerGoogleAddress,
    this.retailerLatitude,
    this.retailerLongitude,
    this.retailerCreatedBy,
    this.retailerGeofenceRange,
    this.retailerPincode,
    this.retailerGstNo,
    this.retailerType,
    this.retailerCreditLimit,
    this.retailerCreditDays,
    this.retailerRemark,
    this.retailerPhotoName,
    this.retailerEmail,
    this.retailerWebsite,
    this.retailerDateOfBirth,
    this.retailerWeddingAnniversaryDate,
    this.areaId,
    this.retailerLastDistributorId,
    this.retailerLastVisitBy,
    this.retailerLastVisitByName,
    this.retailerPhoto,
    this.retailerVerified,
    this.retailerLastOrderDate,
    this.retailerLastVisitDate,
    this.retailerLastOrderAmount,
    this.retailerCreatedDate,
    this.totalDistributors,
    this.distributors,
    this.message,
    this.status,
  });

  factory RetailerDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$RetailerDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetailerDetailsModelToJson(this);

  RetailerDetailsEntity toEntity() => RetailerDetailsEntity(
    applyGstOnOrder: applyGstOnOrder,
    applyFraightInTakeOrder: applyFraightInTakeOrder,
    companyStateId: companyStateId,
    editCustomerDetail: editCustomerDetail,
    startVisitWithOtp: startVisitWithOtp,
    retailerId: retailerId,
    routeId: routeId,
    retailerDailyVisitTimelineId: retailerDailyVisitTimelineId,
    retailerVisitStartDatetime: retailerVisitStartDatetime,
    retailerVisitEndDatetime: retailerVisitEndDatetime,
    routeName: routeName,
    routeNameCode: routeNameCode,
    societyId: societyId,
    countryId: countryId,
    countryName: countryName,
    customerCategoryId: customerCategoryId,
    customerCategoryName: customerCategoryName,
    customerSubCategoryId: customerSubCategoryId,
    customerSubCategoryName: customerSubCategoryName,
    stateId: stateId,
    stateName: stateName,
    cityId: cityId,
    cityName: cityName,
    superDistributorName: superDistributorName,
    areaName: areaName,
    retailerName: retailerName,
    retailerCode: retailerCode,
    retailerContactPerson: retailerContactPerson,
    retailerContactPersonNumber: retailerContactPersonNumber,
    retailerAltContactNumber: retailerAltContactNumber,
    retailerContactPersonCountryCode: retailerContactPersonCountryCode,
    retailerContactPersonNumberWithCountryCode:
        retailerContactPersonNumberWithCountryCode,
    retailerAltCountryCode: retailerAltCountryCode,
    retailerAddress: retailerAddress,
    retailerGoogleAddress: retailerGoogleAddress,
    retailerLatitude: retailerLatitude,
    retailerLongitude: retailerLongitude,
    retailerCreatedBy: retailerCreatedBy,
    retailerGeofenceRange: retailerGeofenceRange,
    retailerPincode: retailerPincode,
    retailerGstNo: retailerGstNo,
    retailerType: retailerType,
    retailerCreditLimit: retailerCreditLimit,
    retailerCreditDays: retailerCreditDays,
    retailerRemark: retailerRemark,
    retailerPhotoName: retailerPhotoName,
    retailerEmail: retailerEmail,
    retailerWebsite: retailerWebsite,
    retailerDateOfBirth: retailerDateOfBirth,
    retailerWeddingAnniversaryDate: retailerWeddingAnniversaryDate,
    areaId: areaId,
    retailerLastDistributorId: retailerLastDistributorId,
    retailerLastVisitBy: retailerLastVisitBy,
    retailerLastVisitByName: retailerLastVisitByName,
    retailerPhoto: retailerPhoto,
    retailerVerified: retailerVerified,
    retailerLastOrderDate: retailerLastOrderDate,
    retailerLastVisitDate: retailerLastVisitDate,
    retailerLastOrderAmount: retailerLastOrderAmount,
    retailerCreatedDate: retailerCreatedDate,
    totalDistributors: totalDistributors,
    distributors: distributors?.map((e) => e.toEntity()).toList(),
    message: message,
    status: status,
  );
}

@JsonSerializable()
class Distributor {
  @JsonKey(name: 'distributor_id')
  String? distributorId;
  @JsonKey(name: 'society_id')
  String? societyId;
  @JsonKey(name: 'distributor_area_id')
  String? distributorAreaId;
  @JsonKey(name: 'distributor_name')
  String? distributorName;
  @JsonKey(name: 'distributor_code')
  String? distributorCode;
  @JsonKey(name: 'distributor_contact_person')
  String? distributorContactPerson;
  @JsonKey(name: 'distributor_contact_person_number')
  String? distributorContactPersonNumber;
  @JsonKey(name: 'distributor_address')
  String? distributorAddress;

  Distributor({
    this.distributorId,
    this.societyId,
    this.distributorAreaId,
    this.distributorName,
    this.distributorCode,
    this.distributorContactPerson,
    this.distributorContactPersonNumber,
    this.distributorAddress,
  });

  factory Distributor.fromJson(Map<String, dynamic> json) =>
      _$DistributorFromJson(json);

  Map<String, dynamic> toJson() => _$DistributorToJson(this);

  DistributorEntity toEntity() => DistributorEntity(
    distributorId: distributorId,
    societyId: societyId,
    distributorAreaId: distributorAreaId,
    distributorName: distributorName,
    distributorCode: distributorCode,
    distributorContactPerson: distributorContactPerson,
    distributorContactPersonNumber: distributorContactPersonNumber,
    distributorAddress: distributorAddress,
  );
}
