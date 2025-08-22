import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/time_sheet/domain/usecase/time_sheet_use_case.dart';
import 'package:myco_flutter/features/time_sheet/presentation/bloc/time_sheet_bloc.dart';
import 'package:myco_flutter/features/time_sheet/presentation/pages/attendance_request_page.dart';
import 'package:myco_flutter/features/time_sheet/presentation/pages/time_sheet_page.dart';

final sl = GetIt.instance;

List<RouteBase> timeSheetRoutes = [
  GoRoute(
    path: RoutePaths.timeSheet,
    name: RoutePaths.timeSheet,
    builder: (context, state) => BlocProvider(
      create: (context) => TimeSheetBloc(sl<TimeSheetUseCase>()),
      child: const TimeSheetPage(),
    ),
  ),
  GoRoute(
    path: RoutePaths.attendanceRequest,
    name: RoutePaths.attendanceRequest,
    builder: (context, state) => const AttendanceRequestPage(),
  ),
];