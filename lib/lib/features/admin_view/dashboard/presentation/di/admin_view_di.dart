import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/services/cache_service.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/admin_view/dashboard/data/data_source/admin_view_local_data_source.dart';
import 'package:myco_flutter/features/admin_view/dashboard/data/data_source/admin_view_local_data_source_impl.dart';
import 'package:myco_flutter/features/admin_view/dashboard/data/data_source/admin_view_remote_data_source.dart';
import 'package:myco_flutter/features/admin_view/dashboard/data/data_source/admin_view_remote_data_source_impl.dart';
import 'package:myco_flutter/features/admin_view/dashboard/data/repositories/admin_view_repository_impl.dart';
import 'package:myco_flutter/features/admin_view/dashboard/domain/repositories/admin_view_repository.dart';
import 'package:myco_flutter/features/admin_view/dashboard/domain/usecases/admin_view_use_case.dart';
import 'package:myco_flutter/features/admin_view/dashboard/presentation/bloc/admin_view_bloc.dart';
import 'package:myco_flutter/features/admin_view/utils/shared_admin_data_holder.dart';

Future<void> adminViewDi(GetIt sl) async {
  // Data Sources
  sl.registerLazySingleton<AdminViewRemoteDataSource>(
    () => AdminViewRemoteDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.employeeMobileApi),
    ),
  );
  sl.registerLazySingleton<AdminViewLocalDataSource>(
    () => AdminViewLocalDataSourceImpl(cacheService: sl<CacheService>()),
  );

  // Repository
  sl.registerLazySingleton<AdminViewRepository>(
    () => AdminViewRepositoryImpl(
      remoteDataSource: sl<AdminViewRemoteDataSource>(),
      localDataSource: sl<AdminViewLocalDataSource>(),
      safeApiCall: sl<SafeApiCall>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => AdminViewUseCase(repository: sl()));

  // BLoC
  sl.registerFactory(() => AdminViewBloc(adminViewUseCase: sl()));

  // 2. Register SharedAdminDataHolder as a lazy singleton
  sl.registerLazySingleton<SharedAdminDataHolder>(SharedAdminDataHolder.new);
}
