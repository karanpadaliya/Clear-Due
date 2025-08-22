import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/my_profile/data/datasources/myprofile_remote_data_source.dart';
import 'package:myco_flutter/features/my_profile/data/datasources/myprofile_remote_data_source_impl.dart';
import 'package:myco_flutter/features/my_profile/data/repositories/my_profile_repository_impl.dart';
import 'package:myco_flutter/features/my_profile/domain/repositories/my_profile_repository.dart';
import 'package:myco_flutter/features/my_profile/domain/usecases/get_profile_data.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/payslip/data/datasources/payslip_remote_datasources.dart';
import 'package:myco_flutter/features/payslip/data/datasources/payslip_remote_datasources_impl.dart';
import 'package:myco_flutter/features/payslip/data/repositories/payslip_repository_impl.dart';
import 'package:myco_flutter/features/payslip/domain/repositories/payslip_repository.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_ctc_details_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_other_earnings_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_salary_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_salary_details_usecase.dart';

// final sl = GetIt.instance;

Future<void> initMyProfileFeatureDI(GetIt sl) async {
  // Bloc
  sl.registerFactory(() => MyProfileBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetProfileData(sl()));

  // Repository
  sl.registerLazySingleton<MyProfileRepository>(
    () => MyProfileRepositoryImpl(sl(), sl()),
  );

  // DataSource
  sl.registerLazySingleton<MyProfileRemoteDataSource>(
    () => MyprofileRemoteDataSourceImpl(
      masterApiClient: sl<ApiClient>(instanceName: VariableBag.masterAPICall),
      apiClient: sl<ApiClient>(instanceName: VariableBag.residentApiNew),
      safeApiCall: sl<SafeApiCall>(),
    ),
  );
}
