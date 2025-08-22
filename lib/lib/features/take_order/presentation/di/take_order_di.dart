import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/payslip/data/datasources/payslip_remote_datasources.dart';
import 'package:myco_flutter/features/payslip/data/datasources/payslip_remote_datasources_impl.dart';
import 'package:myco_flutter/features/payslip/data/repositories/payslip_repository_impl.dart';
import 'package:myco_flutter/features/payslip/domain/repositories/payslip_repository.dart';
import 'package:myco_flutter/features/take_order/data/datasources/take_order_remote_datasource.dart';
import 'package:myco_flutter/features/take_order/data/datasources/take_order_remote_datasource_impl.dart';
import 'package:myco_flutter/features/take_order/data/repositories/take_order_repository_impl.dart';
import 'package:myco_flutter/features/take_order/domain/repositories/take_order_repository.dart';
import 'package:myco_flutter/features/take_order/domain/usecases/get_frequent_products_usecase.dart';
import 'package:myco_flutter/features/take_order/domain/usecases/get_product_category_usecase.dart';
import 'package:myco_flutter/features/take_order/domain/usecases/get_retailer_details_usecase.dart';
import 'package:myco_flutter/features/take_order/presentation/bloc/take_order_bloc.dart';

Future<void> initTakeOrderFeatureDI(GetIt sl) async {
  // Bloc
  sl.registerFactory(() => TakeOrderBloc(sl()));
  sl.registerFactory(() => TakeOrderMainBloc(sl()));
  sl.registerFactory(() => FrequentProductsBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetRetailerDetailsUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetProductCategoryUsecase(sl()));
  sl.registerLazySingleton(() => GetFrequentProductsUsecase(sl()));

  // Repository
  sl.registerLazySingleton<TakeOrderRepository>(
    () => TakeOrderRepositoryImpl(remoteDatasource: sl(), safeApiCall: sl()),
  );

  // DataSource
  sl.registerLazySingleton<TakeOrderRemoteDatasource>(
    () => TakeOrderRemoteDatasourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.residentApiNew),
    ),
  );
}
