import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/cache_service.dart';
import 'package:myco_flutter/features/gallery/data/datasources/gallery_local_data_source.dart';
import 'package:myco_flutter/features/gallery/data/models/gallery_album_response_model.dart';
import 'package:myco_flutter/features/gallery/data/models/get_gallery_new_response_model.dart';

const String kAlbumBox = VariableBag.ALBUM_BOX;

const String kGalleryBox = VariableBag.GALLERY_BOX;
const String kGalleryCacheKey = 'getGalleryAlbumCache';

/// Implementation of [GalleryLocalDataSource] using [CacheService]
class GalleryLocalDataSourceImpl extends GalleryLocalDataSource {
  CacheService cacheService;

  GalleryLocalDataSourceImpl({required this.cacheService});

  /// Retrieves the cached gallery (albums list) if available.
  /// Returns null if not cached.
  @override
  Future<GetGalleryNewResponseModel?> getGalleryNew(
    String albumCacheKey,
  ) async => await cacheService.get<GetGalleryNewResponseModel>(
    kAlbumBox,
    albumCacheKey,
  );

  /// Caches the gallery albums list for offline access.
  @override
  Future<void> cacheGetGalleryNew(
    GetGalleryNewResponseModel getGalleryNewToCache,
    String albumCacheKey,
  ) async {
    await cacheService.put(kAlbumBox, albumCacheKey, getGalleryNewToCache);
  }

  /// Retrieves the cached gallery album images if available.
  /// Returns null if not cached.
  @override
  Future<GalleryAlbumResponseModel?> getGalleryAlbum() async =>
      await cacheService.get<GalleryAlbumResponseModel>(
        kGalleryBox,
        kGalleryCacheKey,
      );

  /// Caches the gallery album images for offline access.
  @override
  Future<void> cacheGetGalleryAlbum(
    GalleryAlbumResponseModel getGalleryAlbumToCache,
  ) async {
    await cacheService.put(
      kGalleryBox,
      kGalleryCacheKey,
      getGalleryAlbumToCache,
    );
  }
}
