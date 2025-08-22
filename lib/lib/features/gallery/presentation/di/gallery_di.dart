import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/network/network_info.dart';
import 'package:myco_flutter/core/services/cache_service.dart';
import 'package:myco_flutter/features/gallery/data/datasources/gallery_local_data_source.dart';
import 'package:myco_flutter/features/gallery/data/datasources/gallery_local_data_source_impl.dart';
import 'package:myco_flutter/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:myco_flutter/features/gallery/data/datasources/gallery_remote_data_source_impl.dart';
import 'package:myco_flutter/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:myco_flutter/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:myco_flutter/features/gallery/domain/usecases/get_gallery_album.dart';
import 'package:myco_flutter/features/gallery/domain/usecases/get_gallery_new.dart';
import 'package:myco_flutter/features/gallery/presentation/bloc/album/album_bloc.dart';
import 'package:myco_flutter/features/gallery/presentation/bloc/gallery/gallery_bloc.dart';

Future<void> galleryDi(GetIt sl) async {
  // data sources
  sl.registerLazySingleton<GalleryRemoteDataSource>(
    () => GalleryRemoteDataSourceImpl(
      apiClient: sl<ApiClient>(instanceName: VariableBag.residentApiNew),
    ),
  );
  sl.registerLazySingleton<GalleryLocalDataSource>(
    () => GalleryLocalDataSourceImpl(cacheService: sl<CacheService>()),
  );

  // repository
  sl.registerLazySingleton<GalleryRepository>(
    () => GalleryRepositoryImpl(
      remoteDataSource: sl<GalleryRemoteDataSource>(),
      localDataSource: sl<GalleryLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // use cases
  sl.registerLazySingleton(
    () => GetGalleryAlbumUseCase(repository: sl<GalleryRepository>()),
  );
  sl.registerLazySingleton(
    () => GetGalleryNewUseCase(repository: sl<GalleryRepository>()),
  );

  // bloc
  sl.registerFactory(
    () => GalleryBloc(getGalleryAlbumUseCase: sl<GetGalleryAlbumUseCase>()),
  );
  sl.registerFactory(
    () => AlbumBloc(getGalleryNewUseCase: sl<GetGalleryNewUseCase>()),
  );
}
