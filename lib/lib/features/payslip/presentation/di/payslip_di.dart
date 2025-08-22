import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/payslip/data/datasources/payslip_remote_datasources.dart';
import 'package:myco_flutter/features/payslip/data/datasources/payslip_remote_datasources_impl.dart';
import 'package:myco_flutter/features/payslip/data/repositories/payslip_repository_impl.dart';
import 'package:myco_flutter/features/payslip/domain/repositories/payslip_repository.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/add_salary_issue_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_ctc_details_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_other_earnings_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_salary_details_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_salary_usecase.dart';
import 'package:myco_flutter/features/payslip/presentation/bloc/payslip_bloc.dart';

Future<void> initPayslipFeatureDI(GetIt sl) async {
  // Bloc
  sl.registerFactory(() => PayslipBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => OtherEarningsBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetCtcDetailsUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetSalaryUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetOtherEarningsUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetSalaryDetailsUsecase(repository: sl()));
  sl.registerLazySingleton(() => AddSalaryIssueUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PayslipRepository>(
    () => PayslipRepositoryImpl(sl(), sl()),
  );

  // DataSource
  sl.registerLazySingleton<PayslipRemoteDatasources>(
    () => PayslipRemoteDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.residentApiNew),
    ),
  );
}
