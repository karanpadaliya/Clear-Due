import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/di/injector.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:myco_flutter/features/employees/presentation/bloc/employee_bloc.dart';
import 'package:myco_flutter/features/employees/presentation/bloc/employee_event.dart';
import 'package:myco_flutter/features/employees/presentation/pages/employees_screen.dart';

List<GoRoute> employeeRoute = [
  GoRoute(
    path: RoutePaths.employees,
    name: 'MemberVC',
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeBloc>(
          create: (_) => sl<EmployeeBloc>()..add(LoadUserData()),
          // child: EmployeesScreen(defaultEmployeeScreen: true),
        ),
        BlocProvider<AppointmentBloc>(
          create: (_) => GetIt.I<AppointmentBloc>(),
        ),
      ],
      child: EmployeesScreen(defaultEmployeeScreen: true),
    ),
  ),
];
