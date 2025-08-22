import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/add_leave_screen_bloc/add_leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/edit_leave_screen_bloc/edit_leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_screen_bloc/leave_screen_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_screen_bloc/leave_screen_event.dart';
import 'package:myco_flutter/features/leave/presentation/pages/add_leave_screen.dart';
import 'package:myco_flutter/features/leave/presentation/pages/add_short_leave_screen.dart';
import 'package:myco_flutter/features/leave/presentation/pages/edit_leave_screen.dart';
import 'package:myco_flutter/features/leave/presentation/pages/leave_screen.dart';
import 'package:myco_flutter/features/leave/presentation/pages/my_leave_balance_screen.dart';
import 'package:myco_flutter/features/leave/presentation/pages/my_team_leaves_screen.dart';

List<RouteBase> leaveRoutes = [
  GoRoute(
    path: RoutePaths.leave,
    name: 'LeaveTrackVC',
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider<LeaveBloc>(create: (_) => GetIt.I<LeaveBloc>()),
        BlocProvider<LeaveScreenBloc>(
          create: (ctx) =>
              LeaveScreenBloc(ctx.read<LeaveBloc>())..add(LoadLeaves()),
        ),
      ],
      child:
          const LeaveScreenView(), // or const LeaveScreen() if LeaveScreenView is not used
    ),
  ),

  GoRoute(
    path: RoutePaths.addShortLeaveScreen,
    name: RoutePaths.addShortLeaveScreen,
    builder: (context, state) => BlocProvider<LeaveBloc>(
      create: (_) => GetIt.I<LeaveBloc>(),
      child: const AddShortLeaveScreen(),
    ),
  ),
  GoRoute(
    path: RoutePaths.addLeaveScreen,
    name: RoutePaths.addLeaveScreen,
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider<LeaveBloc>(create: (_) => GetIt.I<LeaveBloc>()),
        BlocProvider<AddLeaveBloc>(create: (_) => GetIt.I<AddLeaveBloc>()),
      ],
      child: const AddLeaveScreen(),
    ),
  ),

  GoRoute(
    path: RoutePaths.leaveBalance,
    name: RoutePaths.leaveBalance,
    builder: (context, state) => BlocProvider<LeaveBloc>(
      create: (_) => GetIt.I<LeaveBloc>(),
      child: const MyLeaveBalanceScreen(),
    ),
  ),
  GoRoute(
    path: RoutePaths.teamLeaveBalance,
    name: RoutePaths.teamLeaveBalance,
    builder: (context, state) => BlocProvider<LeaveBloc>(
      create: (_) => GetIt.I<LeaveBloc>(),
      child: const MyTeamLeavesScreen(),
    ),
  ),

  GoRoute(
    path: RoutePaths.editLeaveScreen,
    name: RoutePaths.editLeaveScreen,
    builder: (context, state) => BlocProvider<EditLeaveBloc>(
      create: (_) => GetIt.I<EditLeaveBloc>(),
      child: const EditLeave(),
    ),
  ),
];
