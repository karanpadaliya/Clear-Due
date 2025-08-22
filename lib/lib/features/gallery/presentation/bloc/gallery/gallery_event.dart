part of 'gallery_bloc.dart';

sealed class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}

// Event to fetch the gallery album
class GetGalleryAlbum extends GalleryEvent {
  final String societyId;
  final String userId;
  final String languageId;
  final String floorId;
  final String blockId;
  final String? filterYear;

  const GetGalleryAlbum({
    required this.societyId,
    required this.userId,
    required this.languageId,
    required this.floorId,
    required this.blockId,
    this.filterYear,
  });

  @override
  List<Object> get props => [
    societyId,
    userId,
    languageId,
    floorId,
    blockId,
    ?filterYear,
  ];
}

// event to filter year
class FilterAlbums extends GalleryEvent {
  final String year;

  const FilterAlbums(this.year);

  @override
  List<Object> get props => [year];
}

// event to clear filter
class ClearFilter extends GalleryEvent {}
