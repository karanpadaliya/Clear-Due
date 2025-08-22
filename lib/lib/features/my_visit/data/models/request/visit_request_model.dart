class VisitRequestModel {
  final String? getMyVisitsNew;
  final String? Userid;
  final String? FilterDate;
  final String? UserLatitude;
  final String? UserLongitude;
  final String? companyId;


  const VisitRequestModel({
    this.getMyVisitsNew,
    this.Userid,
    this.FilterDate,
    this.UserLatitude,
    this.UserLongitude,
    this.companyId,
  });

  Map<String, dynamic> toJson() => {
    'getMyVisitsNew': getMyVisitsNew,
    'user_id': Userid,
    'filter_date': FilterDate,
    'user_latitude': UserLatitude,
    'user_longitude': UserLongitude,
    'society_id': companyId,
  };
}