import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/assign_work_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/bloc/work_allocation/work_allocation_bloc.dart';
import 'package:myco_flutter/features/work_allocation/presentation/pages/assign_work_page.dart';
import 'package:myco_flutter/features/work_allocation/presentation/pages/detail_page.dart';
import 'package:myco_flutter/features/work_allocation/presentation/pages/work_allocation_page.dart';

List<RouteBase> WorkAllocationRoutes = [
  ShellRoute(
    builder: (BuildContext context, GoRouterState state, Widget child) =>
        MultiBlocProvider(
          providers: [
            BlocProvider<AssignWorkBloc>(
              create: (context) => GetIt.I<AssignWorkBloc>(),
            ),
            BlocProvider<WorkAllocationBloc>(
              create: (context) => GetIt.I<WorkAllocationBloc>(),
            ),
            BlocProvider<CommonApiBloc>(
              create: (context) => GetIt.I<CommonApiBloc>(),
            ),
          ],
          child: child,
        ),
    routes: [
      GoRoute(
        path: RoutePaths.workAllocation,
        name: 'work_allocation',
        builder: (context, state) => const WorkAllocationPage(),
      ),

      GoRoute(
        name: 'assignWork',
        path: '/assign-work',
        builder: (context, state) => const AssignWorkPage(),
      ),

      GoRoute(
        path: RoutePaths.detailPage,
        name: 'detailPage',
        builder: (context, state) {
          final workAllocationId = state.extra as String;
          return DetailPage(workAllocationId: workAllocationId);
        },
      ),
    ],
  ),
];
