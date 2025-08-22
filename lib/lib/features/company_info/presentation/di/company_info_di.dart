import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/features/company_info/data/data_sources/company_info_remote_data_source.dart';
import 'package:myco_flutter/features/company_info/data/data_sources/company_info_remote_data_source_impl.dart';
import 'package:myco_flutter/features/company_info/data/repositories/company_info_repository_impl.dart';
import 'package:myco_flutter/features/company_info/domain/repositories/company_info_repository.dart';
import 'package:myco_flutter/features/company_info/domain/use_cases/get_company_info.dart';
import 'package:myco_flutter/features/company_info/presentation/bloc/company_info_bloc.dart';

Future<void> setupCompanyInfoDi(GetIt sl) async {
  // Data sources
  sl.registerLazySingleton<CompanyInfoRemoteDataSource>(
    () => CompanyInfoRemoteDataSourceImpl(
      dio: sl<Dio>(instanceName: VariableBag.dioWithAuth),
    ),
  );

  // Repository
  sl.registerLazySingleton<CompanyInfoRepository>(
    () => CompanyInfoRepositoryImpl(sl(), sl()),
  );

  // Use case
  sl.registerLazySingleton(() => GetCompanyInfo(repository: sl()));

  // Bloc
  sl.registerFactory(() => CompanyInfoBloc(getCompanyInfo: sl()));
}
