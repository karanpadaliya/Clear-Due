import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/network/network_info.dart';
import 'package:myco_flutter/features/gallery/data/datasources/gallery_local_data_source.dart';
import 'package:myco_flutter/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:myco_flutter/features/gallery/data/models/gallery_request.dart';
import 'package:myco_flutter/features/gallery/domain/entities/gallery_album_entity.dart';
import 'package:myco_flutter/features/gallery/domain/entities/get_gallery_new_entity.dart';
import 'package:myco_flutter/features/gallery/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl extends GalleryRepository {
  final GalleryRemoteDataSource remoteDataSource;
  final GalleryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GalleryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// Fetches gallery albums from the remote source if internet is available.
  ///
  /// - If online:
  ///   - Tries to fetch from the remote data source.
  ///   - On failure, tries to return cached data from local storage.
  ///   - On success, caches the remote data locally and returns it.
  ///
  /// - If offline:
  ///   - Tries to return cached data from local storage.
  ///   - If no cache exists, returns a `NetworkFailure`.
  ///
  /// Returns:
  /// - `Right(GalleryAlbumEntity)` on success.
  /// - `Left(Failure)` on error or no cached data.
  @override
  Future<Either<Failure, GalleryAlbumEntity>> getGalleryAlbum(
    GalleryRequest request,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteModel = await remoteDataSource.getGalleryAlbum(request);

        return remoteModel.fold(
          (failure) async {
            final localGetGalleryAlbum = await localDataSource
                .getGalleryAlbum();

            if (localGetGalleryAlbum != null) {
              return Right(localGetGalleryAlbum.toEntity());
            } else {
              return Left(failure);
            }
          },
          (success) async {
            await localDataSource.cacheGetGalleryAlbum(success);
            return Right(success.toEntity());
          },
        );
      } on Exception catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      final localGetGalleryAlbum = await localDataSource.getGalleryAlbum();
      if (localGetGalleryAlbum != null) {
        return Right(localGetGalleryAlbum.toEntity());
      }

      return const Left(NetworkFailure('No internet connection'));
    }
  }

  /// Fetches the album data using an offline-first approach.
  ///
  /// This method first checks if there is an internet connection:
  /// - If connected:
  ///   - It tries to fetch data from the remote server.
  ///   - On failure, it tries to fetch from the local cache.
  ///   - On success, it caches the data locally for offline use.
  /// - If not connected:
  ///   - It attempts to load previously cached data from the local.
  ///   - If no cached data is found, it returns a NetworkFailure.
  @override
  Future<Either<Failure, GetGalleryNewEntity>> getGalleryNew(
    GalleryRequest request,
  ) async {
    final String albumCacheKey = 'gallery_${request.galleryAlbumId}';

    dev.log('album cache key: $albumCacheKey');

    if (await networkInfo.isConnected) {
      try {
        final remoteModel = await remoteDataSource.getGalleryNew(request);

        return remoteModel.fold(
          (failure) async {
            final localGetGalleryNew = await localDataSource.getGalleryNew(
              albumCacheKey,
            );
            if (localGetGalleryNew != null) {
              return Right(localGetGalleryNew.toEntity());
            } else {
              return Left(failure);
            }
          },
          (success) async {
            await localDataSource.cacheGetGalleryNew(success, albumCacheKey);
            return Right(success.toEntity());
          },
        );
      } on Exception catch (e) {
        dev.log('Error fetching new gallery: $e');
        return Left(ServerFailure(e.toString()));
      }
    } else {
      final localGetGalleryNew = await localDataSource.getGalleryNew(
        albumCacheKey,
      );
      if (localGetGalleryNew != null) {
        return right(localGetGalleryNew.toEntity());
      } else {
        return const Left(NetworkFailure('Album not cached locally'));
      }
    }
  }
}
