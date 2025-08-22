import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/asset/data/datasource/asset_data_source.dart';
import 'package:myco_flutter/features/asset/data/datasource/asset_data_source_impl.dart';
import 'package:myco_flutter/features/asset/data/repositories/asset_repository_impl.dart';
import 'package:myco_flutter/features/asset/domain/repositories/asset_repository.dart';
import 'package:myco_flutter/features/asset/domain/usecases/asset_use_case.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/add_asset/add_asset_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_information/asset_information_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_tabs/asset_tab_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/takeover_asset/takeover_asset_bloc.dart';

void setUpAssetModule(GetIt sl) {
  ///
  // -------- Get Active and Past Asset ----------

  sl.registerLazySingleton<AssetsRemoteDataSource>(
    () => AssetsRemoteDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.employeeMobileApi),
    ),
  );

  sl.registerLazySingleton<AssetsRepository>(
    () => AssetsRepositoryImpl(sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AssetsUseCases>(
    () => AssetsUseCases(repository: sl()),
  );

  sl.registerFactory(() => AssetsBloc(sl(), sl()));

  // -------- Get All Asset ----------

  sl.registerLazySingleton<AllAssetsRemoteDataSource>(
    () => AllAssetsRemoteDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.employeeMobileApi),
    ),
  );

  sl.registerLazySingleton<AllAssetsRepository>(
    () => AllAssetsRepositoryImpl(sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AllAssetsUseCases>(
    () => AllAssetsUseCases(repository: sl()),
  );

  // -------- Get Add Asset ----------

  sl.registerLazySingleton<AddAssetDataSource>(
    () => AddAssetDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.employeeMobileApi),
    ),
  );

  sl.registerLazySingleton<AddAssetRepository>(
    () => AddAssetRepositoryImpl(sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AddAssetUseCases>(
    () => AddAssetUseCases(repository: sl()),
  );

  // -------- Custodian Asset ----------

  sl.registerFactory(() => CustodianUserBloc(sl()));

  // -------- Takeover Asset ----------

  sl.registerFactory(TakeoverAssetBloc.new);

  // -------- GetAssetInformation ----------

  sl.registerLazySingleton<AddAssetUserDataSource>(
    () => AddAssetUserDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.employeeMobileApi),
    ),
  );

  sl.registerLazySingleton<AddAssetUserRepository>(
    () => AddAssetUserRepositoryImpl(sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AddAssetUserUseCases>(
    () => AddAssetUserUseCases(repository: sl()),
  );

  sl.registerFactory(() => AddAssetBloc(sl(), sl()));

  // -------- GetAssetDetailsNew ----------

  sl.registerLazySingleton<GetAssetDetailsDataSource>(
    () => GetAssetDetailsDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.employeeMobileApi),
    ),
  );

  sl.registerLazySingleton<GetAssetDetailsRepository>(
    () => GetAssetDetailsRepositoryImpl(sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetAssetDetailsUseCases>(
    () => GetAssetDetailsUseCases(repository: sl()),
  );

  // -------- GetAssetInformation ----------

  sl.registerLazySingleton<GetAssetInformationDataSource>(
    () => GetAssetInformationDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.employeeMobileApi),
    ),
  );

  sl.registerLazySingleton<GetAssetInformationRepository>(
    () => GetAssetInformationRepositoryImpl(sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetAssetInformationUseCases>(
    () => GetAssetInformationUseCases(repository: sl()),
  );

  sl.registerFactory(() => GetAssetInformationBloc(sl()));
}
