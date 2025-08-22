import 'package:myco_flutter/features/gallery/data/models/gallery_album_response_model.dart';
import 'package:myco_flutter/features/gallery/data/models/get_gallery_new_response_model.dart';

abstract class GalleryLocalDataSource {
  /// Retrieves the locally cached response for `getGalleryNew` API.
  Future<GetGalleryNewResponseModel?> getGalleryNew(String key);

  /// Caches the response from `getGalleryNew` API.
  Future<void> cacheGetGalleryNew(
    GetGalleryNewResponseModel getGalleryNewToCache,
    String key,
  );

  /// Retrieves the locally cached response for `getGalleryAlbum` API.
  Future<GalleryAlbumResponseModel?> getGalleryAlbum();

  /// Caches the response from `getGalleryAlbum` API.
  Future<void> cacheGetGalleryAlbum(
    GalleryAlbumResponseModel getGalleryAlbumToCache,
  );
}
