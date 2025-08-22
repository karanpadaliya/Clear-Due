import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/time_sheet/data/data_source/time_sheet_remote_data_source.dart';
import 'package:myco_flutter/features/time_sheet/data/data_source/time_sheet_remote_data_source_impl.dart';
import 'package:myco_flutter/features/time_sheet/data/repositories/time_sheet_repository_impl.dart';
import 'package:myco_flutter/features/time_sheet/domain/repositories/time_sheet_repository.dart';
import 'package:myco_flutter/features/time_sheet/domain/usecase/time_sheet_use_case.dart';
import 'package:myco_flutter/features/time_sheet/presentation/bloc/time_sheet_bloc.dart';

Future<void> timeSheetDi(GetIt sl) async {
  //Remote Data sources
  sl.registerLazySingleton<TimeSheetRemoteDataSource>(
    TimeSheetRemoteDataSourceImpl.new,
  );

  //Repository
  sl.registerLazySingleton<TimeSheetRepository>(
    () => TimeSheetRepositoryImpl(
      sl<TimeSheetRemoteDataSource>(),
      sl<SafeApiCall>(),
    ),
  );

  //Use Cases
  sl.registerLazySingleton(() => TimeSheetUseCase(repository: sl()));

  //Bloc
  sl.registerFactory(() => TimeSheetBloc(sl()));
}
