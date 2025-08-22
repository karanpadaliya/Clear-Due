import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/visit_entity.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_bloc.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_ui/visit_bloc.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/add_customer.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/add_expense_page.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/assign_to_visit.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/customer_add_new_visit.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/customer_page.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/face_detection_page.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/my_visit_page.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/view_visit_details_page.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/visit_report.dart';

List<RouteBase> myVisitRoutes = [
  // My Visit Route
  ShellRoute(
    builder: (context, state, child) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VisitBloc()..add(InitVisit())),
        BlocProvider(create: (context) => GetIt.I<VisitApiBloc>()),
      ],
      child: child,
    ),
    routes: [
      GoRoute(
        path: RoutePaths.addCustomer,
        name: 'add-customer',
        builder: (context, state) => AddCustomer(),
      ),

      GoRoute(
        path: RoutePaths.customerPage,
        name: 'customer-page',
        builder: (context, state) => CustomerPage(),
      ),

      GoRoute(
        path: RoutePaths.CustomerAddNewVisit,
        name: 'customer-add-new-visit',
        builder: (context, state) => CustomerAddNewVisit(),
      ),

      GoRoute(
        path: RoutePaths.AddExpense,
        name: 'add-expense',
        builder: (context, state) => const AddExpensePage(),
      ),

      GoRoute(
        path: RoutePaths.myVisit,
        name: 'my_visit',
        builder: (context, state) => const MyVisitPage(),
      ),

      GoRoute(
        path: RoutePaths.viewVisitDetails,
        name: 'view-visit-details',
        builder: (context, state) {
          final VistDetails = state.extra as MyVisitEntity;
          return ViewVisitDetailsPage(visit: VistDetails);
        },
      ),

      GoRoute(
        path: RoutePaths.visitReport,
        name: 'visit_report',
        builder: (context, state) => const VisitReport(),
      ),

      GoRoute(
        path: RoutePaths.AssignToVisit,
        name: 'assign-to-visit',
        builder: (context, state) => const AssignToVisit(),
      ),
      GoRoute(
        path: RoutePaths.faceDetection,
        name: 'faceDetection',
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider(
            create: (context) => VisitBloc()..add(LaunchCamera()),
            child: const FaceDetectionPage(),
          ),
        ),
      ),
    ],
  ),
];
