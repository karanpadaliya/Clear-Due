import 'package:get_it/get_it.dart';
import 'package:myco_flutter/features/leave/data/datasources/leave_remote_data_source.dart';
import 'package:myco_flutter/features/leave/data/datasources/leave_remote_data_source_impl.dart';
import 'package:myco_flutter/features/leave/data/repositories/leave_repository_impl.dart';
import 'package:myco_flutter/features/leave/domain/repositories/leave_repository.dart';
import 'package:myco_flutter/features/leave/domain/use_case/leave_use_case.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/add_leave_screen_bloc/add_leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/edit_leave_screen_bloc/edit_leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/pages/add_leave_screen.dart';

Future<void> setUpLeaveDI(GetIt sl) async {
  sl.registerFactory(() => LeaveBloc(sl<LeaveUseCase>()));
  GetIt.I.registerFactory<AddLeaveBloc>(
    () => AddLeaveBloc(
      leaveTypeIds: [],
      leaveTypeNames: [],
      calendarData: LeaveCalendarData(),
    ),
  );

  sl.registerFactory(EditLeaveBloc.new);
  sl.registerLazySingleton(() => LeaveUseCase(repository: sl()));

  sl.registerLazySingleton<LeaveRepository>(
    () => LeaveRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<LeaveRemoteDataSource>(
    LeaveRemoteDataSourceImpl.new,
  );
}
