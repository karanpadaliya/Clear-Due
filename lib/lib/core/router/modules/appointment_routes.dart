import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:myco_flutter/features/appointments/presentation/pages/appointments_page.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';

List<GoRoute> appointmentsRoutes = [
  GoRoute(
    path: RoutePaths.appointments,
    name: 'QuickAppointmentsVC',
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TabbarBloc()),
        BlocProvider(create: (_) => GetIt.I<AppointmentBloc>()),
      ],
      child: const AppointmentsPage(),
    ),
  ),
];
