import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/gallery/domain/usecases/get_gallery_album.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetGalleryAlbumUseCase getGalleryAlbumUseCase;

  GalleryBloc({required this.getGalleryAlbumUseCase})
    : super(GalleryInitial()) {
    // Event to fetch gallery albums from API
    on<GetGalleryAlbum>(_fetchGalleryAlbum);

    // Event to filter albums by selected year
    on<FilterAlbums>(_filterAlbums);

    // Event to clear the applied filter and show all albums
    on<ClearFilter>(_clearFilter);
  }

  // Bloc event fires
  // Use case receives parameters and calls repository
  // GalleryRepositoryImpl.getGalleryAlbum checks network, calls remote data source
  // GalleryAlbumRemoteDataSourceImpl.getGalleryAlbum makes the API call
  // Result sent back up to UI/Bloc
  Future<void> _fetchGalleryAlbum(
    GetGalleryAlbum event,
    Emitter<GalleryState> emit,
  ) async {
    // loading state
    emit(GalleryLoading());

    final param = GetGalleryAlbumParams(
      tag: 'getGalleryAlbum',
      societyId: event.societyId, 
      userId: event.userId, 
      languageId: event.languageId, 
      floorId: event.floorId,
      blockId: event.blockId,
    );

    // Fetching the gallery album
    final freshResult = await getGalleryAlbumUseCase(param);

    // dev.log(
    //   'GalleryBloc._fetchGalleryAlbum: '
    //   'Fetched gallery album with params: $freshResult',
    //   name: 'GalleryBloc',
    // );

    // Emitting the result
    freshResult.fold(
      (failure) {
        if (state is! GalleryLoaded) {
          emit(GalleryError(message: failure.message));
        }
      },
      (entity) {
        final individualAlbums = entity.eventAlbum ?? [];
        emit(
          GalleryLoaded(
            allAlbums: individualAlbums,
            filteredAlbums: individualAlbums,
          ),
        );
      },
    );
  }

  /// Filters the gallery albums based on the selected year.
  void _filterAlbums(FilterAlbums event, Emitter<GalleryState> emit) {
    // Get the current state to access the full list of albums
    final currentState = state;

    // We can only filter if the data has already been loaded
    if (currentState is GalleryLoaded) {
      // Filter the albums by matching the event year with the album eventDate year
      final filteredList = currentState.allAlbums.where((album) {
        final rawDate = album.eventDate;

        // Skip if null or empty
        if (rawDate == null || rawDate.trim().isEmpty) return false;

        try {
          final parsedDate = DateTime.parse(rawDate);
          return parsedDate.year.toString() == event.year;
        } catch (e) {
          dev.log(
            'Date parse error: $e | value: $rawDate',
            name: 'GalleryBloc',
          );
          return false;
        }
      }).toList();

      // Emit a new state with the updated filtered list and the selected year
      emit(
        currentState.copyWith(
          filteredAlbums: filteredList,
          selectedYear: event.year,
        ),
      );
    }
  }

  /// Clears any applied filter and resets the album list to show all albums.
  void _clearFilter(ClearFilter event, Emitter<GalleryState> emit) {
    final currentState = state;
    if (currentState is GalleryLoaded) {
      emit(currentState.copyWith(filteredAlbums: currentState.allAlbums));
    }
  }
}
