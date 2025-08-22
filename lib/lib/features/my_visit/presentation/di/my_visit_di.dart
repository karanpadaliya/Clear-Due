import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/my_visit/data/datasources/myvisit_remote_data_source.dart';
import 'package:myco_flutter/features/my_visit/data/datasources/myvisit_remote_data_source_impl.dart';
import 'package:myco_flutter/features/my_visit/data/repositories/my_visit_repository_impl.dart';
import 'package:myco_flutter/features/my_visit/domain/repositories/my_visit_repository.dart';
import 'package:myco_flutter/features/my_visit/domain/usecases/myvisit_usecase.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_api/visit_api_bloc.dart';

void myVisitDi(GetIt sl) {
  // sl.registerFactory(VisitBloc.new);

  // Bloc
  sl.registerFactory(() => VisitApiBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetVisitData(sl()));

  // Repository
  sl.registerLazySingleton<MyVisitRepository>(
    () => MyVisitRepositoryImpl(sl(), sl()),
  );

  // DataSource
  sl.registerLazySingleton<MyVisitRemoteDataSource>(
    () => MyVisitRemoteDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.residentApiNew),
      safeApiCall: sl<SafeApiCall>(),
    ),
  );
}
