class RetailerDetailsEntity {
  final String? applyGstOnOrder;
  final String? applyFraightInTakeOrder;
  final String? companyStateId;
  final bool? editCustomerDetail;
  final bool? startVisitWithOtp;
  final String? retailerId;
  final dynamic routeId;
  final String? retailerDailyVisitTimelineId;
  final String? retailerVisitStartDatetime;
  final String? retailerVisitEndDatetime;
  final dynamic routeName;
  final String? routeNameCode;
  final String? societyId;
  final String? countryId;
  final String? countryName;
  final String? customerCategoryId;
  final String? customerCategoryName;
  final String? customerSubCategoryId;
  final String? customerSubCategoryName;
  final String? stateId;
  final String? stateName;
  final String? cityId;
  final String? cityName;
  final String? superDistributorName;
  final String? areaName;
  final String? retailerName;
  final String? retailerCode;
  final String? retailerContactPerson;
  final String? retailerContactPersonNumber;
  final String? retailerAltContactNumber;
  final String? retailerContactPersonCountryCode;
  final String? retailerContactPersonNumberWithCountryCode;
  final String? retailerAltCountryCode;
  final String? retailerAddress;
  final String? retailerGoogleAddress;
  final String? retailerLatitude;
  final String? retailerLongitude;
  final String? retailerCreatedBy;
  final String? retailerGeofenceRange;
  final String? retailerPincode;
  final String? retailerGstNo;
  final String? retailerType;
  final String? retailerCreditLimit;
  final String? retailerCreditDays;
  final String? retailerRemark;
  final String? retailerPhotoName;
  final String? retailerEmail;
  final String? retailerWebsite;
  final String? retailerDateOfBirth;
  final String? retailerWeddingAnniversaryDate;
  final String? areaId;
  final String? retailerLastDistributorId;
  final String? retailerLastVisitBy;
  final String? retailerLastVisitByName;
  final String? retailerPhoto;
  final bool? retailerVerified;
  final String? retailerLastOrderDate;
  final String? retailerLastVisitDate;
  final String? retailerLastOrderAmount;
  final String? retailerCreatedDate;
  final String? totalDistributors;
  final List<DistributorEntity>? distributors;
  final String? message;
  final String? status;

  const RetailerDetailsEntity({
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
}

class DistributorEntity {
  final String? distributorId;
  final String? societyId;
  final String? distributorAreaId;
  final String? distributorName;
  final String? distributorCode;
  final String? distributorContactPerson;
  final String? distributorContactPersonNumber;
  final String? distributorAddress;

  const DistributorEntity({
    this.distributorId,
    this.societyId,
    this.distributorAreaId,
    this.distributorName,
    this.distributorCode,
    this.distributorContactPerson,
    this.distributorContactPersonNumber,
    this.distributorAddress,
  });
}
