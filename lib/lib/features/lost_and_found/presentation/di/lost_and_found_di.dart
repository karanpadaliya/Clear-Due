import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/lost_and_found/data/data_sources/lost_and_found_data_source.dart';
import 'package:myco_flutter/features/lost_and_found/data/data_sources/lost_and_found_data_source_impl.dart';
import 'package:myco_flutter/features/lost_and_found/data/repositories/lost_and_found_repository_impl.dart';
import 'package:myco_flutter/features/lost_and_found/domain/repositories/lost_and_found_repository.dart';
import 'package:myco_flutter/features/lost_and_found/domain/use_cases/add_lost_and_found_item_use_case.dart';
import 'package:myco_flutter/features/lost_and_found/domain/use_cases/delete_lost_and_found_item_use_case.dart';
import 'package:myco_flutter/features/lost_and_found/domain/use_cases/edit_lost_and_found_item_use_case.dart';
import 'package:myco_flutter/features/lost_and_found/domain/use_cases/lost_and_found_usecases.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_bloc.dart';

void setupLostAndFoundDi(GetIt sl) {
  // DataSource
  sl.registerLazySingleton<LostAndFoundDataSource>(
    () => LostAndFoundDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.employeeMobileApi),
    ),
  );

  // Repository
  sl.registerLazySingleton<LostAndFoundRepository>(
    () => LostAndFoundRepositoryImpl(sl(), sl()),
  );

  // UseCase
  sl.registerLazySingleton<GetLostAndFoundItemsUseCase>(
    () => GetLostAndFoundItemsUseCase(sl()),
  );
  sl.registerLazySingleton<AddLostAndFoundItemUseCase>(
    () => AddLostAndFoundItemUseCase(sl()),
  );
  sl.registerLazySingleton<DeleteLostAndFoundItemUseCase>(
    () => DeleteLostAndFoundItemUseCase(sl()),
  );
  sl.registerLazySingleton<EditLostAndFoundItemUseCase>(
    () => EditLostAndFoundItemUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<LostAndFoundBloc>(
    () => LostAndFoundBloc(
      getItemsUseCase: sl(),
      addItemsUseCase: sl(),
      deleteItemsUseCase: sl(),
      editItemsUseCase: sl(),
    ),
  );
}
