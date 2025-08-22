
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/chat/data/datasources/chat_datasources.dart';
import 'package:myco_flutter/features/chat/data/datasources/chat_datasources_impl.dart';
import 'package:myco_flutter/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:myco_flutter/features/chat/domain/repositories/chat_repository.dart';
import 'package:myco_flutter/features/chat/domain/usecases/get_all_departments.dart';
import 'package:myco_flutter/features/chat/domain/usecases/get_all_employee.dart';
import 'package:myco_flutter/features/chat/domain/usecases/get_member_list.dart';
import 'package:myco_flutter/features/chat/domain/usecases/get_group_chat_list.dart';
import 'package:myco_flutter/features/chat/domain/usecases/grt_member_chat_list.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/bloc/select_emp_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/chat_list_bloc/chat_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/group_chat_bloc/group_chat_bloc.dart';

// final sl = GetIt.instance;

Future<void> initChatFeatureDI(GetIt sl) async {
  // Bloc
  sl.registerFactory(() => ChatListBloc(sl(), sl() , sl()));
  sl.registerFactory(() => GroupChatBloc(sl()));
  sl.registerFactory(() => SelectEmpBloc(sl(), sl(),));

  // UseCase
  sl.registerLazySingleton(() => GetMemberList(sl()));
  sl.registerLazySingleton(() => GetGroupChatList(sl()));
  sl.registerLazySingleton(() => GetMemberChatList(sl()));
  sl.registerLazySingleton(() => GetAllDepartments(sl()));
  sl.registerLazySingleton(() => GetAllEmployee(sl()));
  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(sl(), sl()),
  );
  // DataSource
  sl.registerLazySingleton<ChatDatasources>(
    () => ChatDatasourcesImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.residentApiNew),
      safeApiCall: sl<SafeApiCall>(),
    ),
  );
}
