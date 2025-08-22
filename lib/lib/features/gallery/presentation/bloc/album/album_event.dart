part of 'album_bloc.dart';

sealed class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}


// Event to fetch a new gallery album
class GetGalleryNew extends AlbumEvent {
  final String societyId;
  final String userId;
  final String languageId;
  final String floorId;
  final String blockId;
  final String galleryAlbumId;

  const GetGalleryNew({
    required this.societyId,
    required this.userId,
    required this.languageId,
    required this.floorId,
    required this.blockId,
    required this.galleryAlbumId,
  });

  @override
  List<Object> get props => [
    societyId,
    userId,
    languageId,
    floorId,
    blockId,
    galleryAlbumId,
  ];
}

class DownloadAlbum extends AlbumEvent {
  final String fileUrl;
  final bool isShare;

  const DownloadAlbum({
    required this.fileUrl,
    this.isShare = false, // if user tapped Share, this will be true
  });

  @override
  List<Object> get props => [fileUrl, isShare];
}

class UpdateDownloadProgress extends AlbumEvent {
  final double progress;
  final bool isShare;

  const UpdateDownloadProgress(this.progress, {this.isShare = false});

  @override
  List<Object> get props => [progress, isShare];
}
