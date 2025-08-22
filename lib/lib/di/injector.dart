import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/error/global_error_handler/global_error_cubit.dart';
import 'package:myco_flutter/core/router/app_router.dart';
import 'package:myco_flutter/core/services/cache_service.dart';
import 'package:myco_flutter/core/services/firebase_messaging_service.dart'; // Added import
import 'package:myco_flutter/core/services/hive_cache_service.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/di/modules/network_module.dart';
import 'package:myco_flutter/features/admin_view/dashboard/presentation/di/admin_view_di.dart';
import 'package:myco_flutter/features/appointments/presentation/di/appointment_di.dart';
import 'package:myco_flutter/features/asset/presentation/di/asset_di.dart';
import 'package:myco_flutter/features/chat/presentation/di/chat_list_di.dart';
import 'package:myco_flutter/features/circular/presentation/di/circular_di.dart';
import 'package:myco_flutter/features/common_api/presentation/di/common_api_di.dart';
import 'package:myco_flutter/features/company_info/presentation/di/company_info_di.dart';
import 'package:myco_flutter/features/company_selector/presentation/di/company_select_di.dart';
import 'package:myco_flutter/features/company_selector/presentation/di/device_change_di.dart';
import 'package:myco_flutter/features/company_selector/presentation/di/request_otp_di.dart';
import 'package:myco_flutter/features/dashboard/presentation/di/dashboard_di.dart';
import 'package:myco_flutter/features/employees/presentation/di/employee_di.dart';
import 'package:myco_flutter/features/gallery/presentation/di/gallery_di.dart';
import 'package:myco_flutter/features/holiday/presentation/di/holiday_di.dart';
import 'package:myco_flutter/features/language_selector/presentation/di/language_di.dart';
import 'package:myco_flutter/features/leave/presentation/di/leave_di.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/di/lost_and_found_di.dart';
import 'package:myco_flutter/features/my_profile/presentation/di/my_profile_di.dart';
import 'package:myco_flutter/features/my_visit/presentation/di/my_visit_di.dart';
import 'package:myco_flutter/features/payslip/presentation/di/payslip_di.dart';
import 'package:myco_flutter/features/sign_in/presentation/di/primary_register_di.dart';
import 'package:myco_flutter/features/speech_menu_search/presentation/di/speech_di.dart';
import 'package:myco_flutter/features/splash/presentation/di/splash_di.dart';
import 'package:myco_flutter/features/take_order/presentation/di/take_order_di.dart';
import 'package:myco_flutter/features/time_sheet/presentation/di/time_sheet_di.dart';
import 'package:myco_flutter/features/work_allocation/presentation/di/work_allocation_di.dart';
import 'package:myco_flutter/features/work_from_home/presentation/di/wfh_di.dart';

final sl = GetIt.instance;

Future<void> initDi() async {
  sl.registerSingleton<GlobalErrorCubit>(GlobalErrorCubit());

  sl.registerSingleton<AppRouter>(AppRouter());

  // Register our Hive-based CacheService as a singleton
  sl.registerSingleton<CacheService>(HiveCacheService());
  sl.registerLazySingleton<FirebaseMessagingService>(() => FirebaseMessagingService()); // Added registration

  sl.registerSingleton<PreferenceManager>(PreferenceManager());
  // await initFirebaseModule(sl);

  await initNetworkModule(sl);

  // Initialize feature modules
  //========Language Selector=========
  setupLanguageDI(sl);

  //========Splash=========
  splashDi(sl);

  //========Login=========
  await setupLoginDi(sl);

  //========Device Change=========
  setupDeviceChangeDi(sl);

  //========Company Selector=========
  companySelectorDi(sl);

  //========Dashboard=========
  DashboardDi(sl);

  //========Inquiry=========
  InquiryDi(sl);

  //========Face Detection=========
  myVisitDi(sl);

  // ========Admin View=========
  await adminViewDi(sl);

  // ========Employee View=========
  employeeDi(sl);

  //========Company Info=========
  setupCompanyInfoDi(sl);

  //========Holiday=========
  setupHolidayDi(sl);

  //Leave
  setUpLeaveDI(sl);

  //Work Allocation
  setUpWorkAllocationDI(sl);

  //========Payslip=========
  initPayslipFeatureDI(sl);

  //========Chat=========
  initChatFeatureDI(sl);

  //========Gallery=========
  galleryDi(sl);

  //Time Sheet
  timeSheetDi(sl);
  //========My Profile=========
  initMyProfileFeatureDI(sl);

  //========Assets=========
  setUpAssetModule(sl);

  //========Sign in=========
  setupPrimaryRegisterDi(sl);

  //========Common Api=========
  CommonApiDi(sl);

  //========Circular Api=========
  CircularDi(sl);

  //========Work From Home=========
  setUpWfhModule(sl);

  setUpReqWfhModule(sl);
  //========Lost And Found=========
  setupLostAndFoundDi(sl);

  //========Take Order=========
  initTakeOrderFeatureDI(sl);

  setupSpeechToSearchDI(sl);

  //====== Appointment =====
  appointmentDi(sl);
}
