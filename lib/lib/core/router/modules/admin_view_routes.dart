// lib/core/router/modules/admin_view_routes.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/admin_view/dashboard/presentation/bloc/admin_view_bloc.dart';
import 'package:myco_flutter/features/admin_view/dashboard/presentation/pages/admin_view_maintenance_page.dart';
import 'package:myco_flutter/features/admin_view/dashboard/presentation/pages/admin_view_page.dart';
import 'package:myco_flutter/features/work_from_home/presentation/pages/admin_wfh_request_page.dart';

final List<RouteBase> adminViewRoutes = [
  GoRoute(
    path: RoutePaths.adminView,
    name: RoutePaths.adminView,
    builder: (context, state) => BlocProvider(
      create: (_) => GetIt.I<AdminViewBloc>(),
      child: const AdminViewPage(),
    ),
    // Nest all sub-routes inside the main adminView route.
    routes: [
      GoRoute(
        path: RoutePaths.adminPendingLeaves
            .split('/')
            .last, // e.g., 'pending-leaves'
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Pending Leaves',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminPendingExpenses.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Pending Expenses',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminWfhApproval.split('/').last,
        builder: (context, state) => const AdminWfhRequestPage(),
      ),
      GoRoute(
        path: RoutePaths.adminPastDateAttendance.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Past Date Attendance Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminPunchOutMissing.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Punch Out Missing Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminEscalation.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Escalation Requests',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminIdeaApproval.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Idea Box Approval',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminOutOfRangeRequest.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Out of Range Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminApproveEmployee.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Approve Employee',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminOnboarding.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Employee Onboarding',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminAbsentPresent.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Absent/Present View',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminMonthlyAttendance.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Monthly Attendance',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminDeviceChange.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Device Change Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminTrackEmployee.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Track Employee',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminPersonalInfo.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Personal Info Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminWorkReport.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Work Report',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminAdvanceSalaryRequest.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Advance Salary Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminLoanRequest.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Loan Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminPendingVisitApproval.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Pending Visit Approval',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminEndVisitApproval.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'End Visit Approval',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminViewEmployeeVisits.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'View Employee Visits',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminShiftChangeRequests.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Shift Change Requests',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminFaceChangeRequests.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Face Change Requests',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminAdvanceExpenseRequest.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Advance Expense Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminShortLeaveRequest.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Short Leave Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminBreakRequest.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Break Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminGpsInternetSummary.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'GPS Internet Summary',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminAutoLeaves.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Auto Leaves',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminViewShortLeaves.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'View Short Leaves',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminSandwichLeaves.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Sandwich Leaves',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminReviewWorkReport.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Review Work Report',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminWorkReportSummary.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Work Report Summary',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminTrackingSetting.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Tracking Setting',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminLiveMapView.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Live Map View',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminTravelSummary.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Travel Summary',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminPaidExpense.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Paid Expenses',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminUnpaidExpense.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Unpaid Expenses',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminOffboarding.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Employee Offboarding',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminContactInfo.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Contact Info Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminPastExperience.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Past Experience Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminEducation.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Education Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminAchievements.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Achievements Request',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: RoutePaths.adminEmployeesFace.split('/').last,
        builder: (context, state) => AdminViewMaintenancePage(
          title: 'Employees Face Management',
          extra: state.extra as Map<String, dynamic>?,
        ),
      ),
    ],
  ),
];
