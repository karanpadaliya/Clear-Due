import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/features/circular/data/data_source/circular_data_source.dart';
import 'package:myco_flutter/features/circular/data/data_source/circular_data_source_impl.dart';
import 'package:myco_flutter/features/circular/data/repositories/circular_repository_impl.dart';
import 'package:myco_flutter/features/circular/domain/repositories/circular_repository.dart';
import 'package:myco_flutter/features/circular/domain/usecase/circular_usecase.dart';
import 'package:myco_flutter/features/circular/presentation/bloc/circular_bloc.dart';

Future<void> CircularDi(GetIt sl) async {
  // Bloc
  sl.registerFactory(() => CircularBloc(registerUseCase: sl()));

  // Use case
  sl.registerLazySingleton(() => CircularUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<CircularRepository>(() => CircularRepositoryImpl(sl(), sl()));

  // Data sources
  sl.registerLazySingleton<CircularDataSource>(() => CircularDataSourceImpl(dio: sl<Dio>(instanceName: VariableBag.dioWithAuth)));
}