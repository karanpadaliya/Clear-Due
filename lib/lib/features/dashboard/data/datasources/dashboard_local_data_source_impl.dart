import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/cache_service.dart';
import 'package:myco_flutter/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:myco_flutter/features/dashboard/data/models/home_menu_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/my_unit_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/attendance_type_response.dart'; // NEW

const String kHomeMenuBox = VariableBag.HOME_MENU_BOX;
const String kHomeMenuCacheKey = 'homeMenuCache';
const String kMyUnitsBox = VariableBag.MY_UNIT_BOX;
const String kMyUnitsKey = 'MyUnits';
const String kAttendanceTypeBox = VariableBag.ATTENDANCE_TYPE_BOX;
const String kAttendanceTypeKey = 'AttendanceTypeCache';

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final CacheService cacheService;

  DashboardLocalDataSourceImpl({required this.cacheService});

  @override
  Future<void> cacheHomeMenu(HomeMenuResponse menuToCache) async {
    await cacheService.put(kHomeMenuBox, kHomeMenuCacheKey, menuToCache);
  }

  @override
  Future<HomeMenuResponse?> getHomeMenu() async =>
      await cacheService.get<HomeMenuResponse>(kHomeMenuBox, kHomeMenuCacheKey);

  @override
  Future<void> cacheMyUnits(MyUnitResponse menuToCache) async {
    await cacheService.put(kMyUnitsBox, kMyUnitsKey, menuToCache);
  }

  @override
  Future<MyUnitResponse?> getMyUnits() async =>
      await cacheService.get<MyUnitResponse>(kMyUnitsBox, kMyUnitsKey);

  // NEW IMPLEMENTATION FOR ATTENDANCE TYPE CACHING
  @override
  Future<void> cacheAttendanceType(AttendanceTypeResponse attendanceTypeToCache) async {
    await cacheService.put(kAttendanceTypeBox, kAttendanceTypeKey, attendanceTypeToCache);
  }

  @override
  Future<AttendanceTypeResponse?> getAttendanceType() async =>
      await cacheService.get<AttendanceTypeResponse>(kAttendanceTypeBox, kAttendanceTypeKey);
}