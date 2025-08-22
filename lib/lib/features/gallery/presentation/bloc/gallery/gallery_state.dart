part of 'gallery_bloc.dart';

sealed class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}

final class GalleryInitial extends GalleryState {}

final class GalleryLoading extends GalleryState {}

// State when the gallery album is successfully loaded
final class GalleryLoaded extends GalleryState {
  /// List of all albums fetched from the API (unfiltered).
  final List<EventAlbumEntity> allAlbums;

  /// List of albums to be displayed in the UI (filtered or same as allAlbums if no filter is applied).
  final List<EventAlbumEntity> filteredAlbums;

  // Keeps track of the currently selected year
  final String? selectedYear;

  const GalleryLoaded({
    this.allAlbums = const [],
    this.filteredAlbums = const [],
    this.selectedYear,
  });

  /// Creates a copy of the current state with updated values.
  /// This is essential for emitting a new state without losing existing data.
  GalleryLoaded copyWith({
    List<EventAlbumEntity>? allAlbums,
    List<EventAlbumEntity>? filteredAlbums,
    String? selectedYear,
  }) => GalleryLoaded(
    allAlbums: allAlbums ?? this.allAlbums,
    filteredAlbums: filteredAlbums ?? this.filteredAlbums,
    selectedYear: selectedYear,
  );

  @override
  List<Object> get props => [allAlbums, filteredAlbums, selectedYear ?? ''];
}

final class GalleryError extends GalleryState {
  final String message;

  const GalleryError({required this.message});

  @override
  List<Object> get props => [message];
}
