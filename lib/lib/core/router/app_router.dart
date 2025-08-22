import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/modules/admin_view_routes.dart';
import 'package:myco_flutter/core/router/modules/appointment_routes.dart';
import 'package:myco_flutter/core/router/modules/assets_routes.dart';
import 'package:myco_flutter/core/router/modules/chat_routes.dart';
import 'package:myco_flutter/core/router/modules/company_info_routes.dart';
import 'package:myco_flutter/core/router/modules/dashboard_routes.dart';
import 'package:myco_flutter/core/router/modules/employee_view_routes.dart';
import 'package:myco_flutter/core/router/modules/gallery_routes.dart';
import 'package:myco_flutter/core/router/modules/holiday_routes.dart';
import 'package:myco_flutter/core/router/modules/initial_routes.dart';
import 'package:myco_flutter/core/router/modules/leave_routes.dart';
import 'package:myco_flutter/core/router/modules/lost_and_found_routes.dart';
import 'package:myco_flutter/core/router/modules/my_profile.dart';
import 'package:myco_flutter/core/router/modules/my_visit_routes.dart';
import 'package:myco_flutter/core/router/modules/my_wfh_routes.dart';
import 'package:myco_flutter/core/router/modules/payslip_routes.dart';
import 'package:myco_flutter/core/router/modules/take_order_routes.dart';
import 'package:myco_flutter/core/router/modules/time_sheet_routes.dart';
import 'package:myco_flutter/core/router/modules/work_allocation_routes.dart';
import 'package:myco_flutter/core/router/modules/custom_notification_routes.dart';
import 'package:myco_flutter/core/router/route_paths.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GlobalKey<NavigatorState> get navigatorKey => _rootNavigatorKey;
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    // Don't change this line keep it as is [RoutePaths.splash] rs 500 penalty if anyone changes it
    // initialLocation: RoutePaths.dashboard,
    observers: [
      // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
    routes: [
      ...initialRoutes,

      // GoRoute(
      //   path: RoutePaths.details,
      //   name: 'details',
      //   builder: (context, state) => const DetailsPage(),
      // ),
      ...DashboardRoutes,

      ...HolidayRoutes,

      ...CompanyInfoRoutes,

      // GoRoute(
      //   path: RoutePaths.language,
      //   name: 'language',
      //   builder: (context, state) => const LanguageSelectorPage(),
      // ),
      ...takeOrderRoutes,

      ...payslipRoutes,

      ...chatRoutes,
      ...employeeRoute,

      // In the code where you NAVIGATE TO ContactAdminPage
      ...myVisitRoutes,

      ...lostAndFoundRoutes,

      ...adminViewRoutes,

      ...assetsRoutes,

      ...appointmentsRoutes,

      ...WorkAllocationRoutes,

      ...myProfileRoutes,

      ...leaveRoutes,

      ...galleryRoutes,

      ...timeSheetRoutes,

      ...WFHRoutes,

      ...customNotificationRoutes,

      // Add all modular routes here
      // ...authRoutes,
      // ...homeRoutes,
    ],
    // errorBuilder: (context, state) => const ErrorScreen(),
  );
}
