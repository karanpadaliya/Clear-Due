import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/work_from_home/data/data_source/add_wfh/my_wfh_data_source.dart';
import 'package:myco_flutter/features/work_from_home/data/data_source/add_wfh/my_wfh_data_source_impl.dart';
import 'package:myco_flutter/features/work_from_home/data/data_source/admin_req_wfh/req_wfh_data_source.dart';
import 'package:myco_flutter/features/work_from_home/data/data_source/admin_req_wfh/req_wfh_data_source_impl.dart';
import 'package:myco_flutter/features/work_from_home/data/repositories/add_wfh/add_wfh_repository_impl.dart';
import 'package:myco_flutter/features/work_from_home/data/repositories/admin_req_wfh/req_wfh_repository_impl.dart';
import 'package:myco_flutter/features/work_from_home/domain/repositories/add_wfh/add_wfh_repository.dart';
import 'package:myco_flutter/features/work_from_home/domain/repositories/admin_req_wfh/req_wfh_repository.dart';
import 'package:myco_flutter/features/work_from_home/domain/usecases/add_wfh/add_wfh_use_case.dart';
import 'package:myco_flutter/features/work_from_home/domain/usecases/admin_req_wfh/req_wfh_use_case.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_bloc.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/admin_req_wfh/req_wfh_bloc.dart';

void setUpWfhModule(GetIt sl) {
  // Data sources
  sl.registerLazySingleton<AddWfhRemoteDataSource>(
    () => AddWfhDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.employeeMobileApi),
    ),
  );
  // Repository
  sl.registerLazySingleton<AddWfhRepository>(
    () => AddWfhRepositoryImpl(sl(), remoteDataSource: sl()),
  );
  // Use case
  sl.registerLazySingleton<WfhUseCases>(() => WfhUseCases(repository: sl()));

  // Bloc
  sl.registerFactory(() => AddWfhBloc(addWfhUseCase: sl()));
}

//--------------------- Admin View Requests--------------------------------
Future<void> setUpReqWfhModule(GetIt sl) async {
  // Bloc
  sl.registerFactory(() => RequestWfhBloc(requestWfhUseCase: sl()));

  // Use case
  sl.registerLazySingleton(() => ReqWfhUseCases(repository: sl()));

  //repository
  sl.registerLazySingleton<RequestWfhRepository>(
    () => ReqWfhRepositoryImpl(sl(), sl()),
  );

  //data source
  sl.registerLazySingleton<AdminReqWfhDataSource>(
    AdminReqWfhDataSourceImpl.new,
  );
}
