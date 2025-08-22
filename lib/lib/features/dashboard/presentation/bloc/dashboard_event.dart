part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetIDCardDetails extends DashboardEvent {
  final String? getIDCardDetails, userId, companyId, languageId;
  const GetIDCardDetails({
    this.getIDCardDetails = 'getIDCardDetails',
    this.userId,
    this.companyId,
    this.languageId,
  });
}

class GetAppMenuGridWithCategory extends DashboardEvent {
  final String? getAppMenuGridWithCat,
      userId,
      companyId,
      languageId,
      society_id,
      unit_id,
      country_id,
      state_id,
      city_id,
      device,
      language_id;
  const GetAppMenuGridWithCategory({
    this.getAppMenuGridWithCat = 'getAppMenuGridWithCategory',
    this.society_id,
    this.unit_id,
    this.country_id,
    this.state_id,
    this.city_id,
    this.device,
    this.language_id,
    this.userId,
    this.companyId,
    this.languageId,
  });
}

class GetMyUnits extends DashboardEvent {
  final GetMyUnitsRequest request;
  const GetMyUnits({required this.request});
}

class GetAttendanceType extends DashboardEvent {
  final String getAttendanceTypeNew;
  final String companyId;
  final String unitId;
  final String registeredUserId;
  final String languageId;
  final String lastFetchLocationLatitude;
  final String lastFetchLocationLongitude;
  final String lastFetchLocationAccuracy;
  final String shiftTimeId;
  final bool isRefresh;

  const GetAttendanceType({
    this.getAttendanceTypeNew = 'getAttendanceTypeNew',
    required this.companyId,
    required this.unitId,
    required this.registeredUserId,
    required this.languageId,
    required this.lastFetchLocationLatitude,
    required this.lastFetchLocationLongitude,
    required this.lastFetchLocationAccuracy,
    required this.shiftTimeId,
    this.isRefresh = false,
  });

  @override
  List<Object> get props => [
    getAttendanceTypeNew,
    companyId,
    unitId,
    registeredUserId,

    languageId,
    lastFetchLocationLatitude,
    lastFetchLocationLongitude,
    lastFetchLocationAccuracy,
    shiftTimeId,
    isRefresh,
  ];
}

class PunchIn extends DashboardEvent {
  final AttendancePunchInRequest request;
  const PunchIn({required this.request});
  @override
  List<Object> get props => [request];
}

class PunchOut extends DashboardEvent {
  final AttendancePunchOutRequest request;
  const PunchOut({required this.request});
  @override
  List<Object> get props => [request];
}

class BreakIn extends DashboardEvent {
  final BreakInRequest request;
  const BreakIn({required this.request});
  @override
  List<Object> get props => [request];
}

class BreakOut extends DashboardEvent {
  final BreakOutRequest request;
  const BreakOut({required this.request});
  @override
  List<Object> get props => [request];
}
