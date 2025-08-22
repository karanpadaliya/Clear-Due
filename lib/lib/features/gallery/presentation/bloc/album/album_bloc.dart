import 'dart:developer' as dev;
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/gallery/domain/entities/get_gallery_new_entity.dart';
import 'package:myco_flutter/features/gallery/domain/usecases/get_gallery_new.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetGalleryNewUseCase getGalleryNewUseCase;

  AlbumBloc({required this.getGalleryNewUseCase}) : super(AlbumInitial()) {
    // Registering the event handler for fetching gallery new albums
    on<GetGalleryNew>(_getGalleryNewAlbum);

    on<DownloadAlbum>(_downloadGallery);
    on<UpdateDownloadProgress>(_updateDownloadProgress);
  }

  // Bloc event fires
  // Use case receives parameters and calls repository
  // GalleryRepositoryImpl.getGalleryNew checks network, calls remote data source
  // GetGalleryNewRemoteDataSourceImpl.getGalleryNew makes the API call
  // Result sent back up to UI/Bloc
  Future<void> _getGalleryNewAlbum(
    GetGalleryNew event,
    Emitter<AlbumState> emit,
  ) async {
    // loading state
    emit(AlbumLoading());

    final param = GetGalleryNewParams(
      tag: 'getGalleryNew',
      societyId: event.societyId,
      userId: event.userId,
      languageId: event.languageId,
      floorId: event.floorId,
      blockId: event.blockId,
      galleryAlbumId: event.galleryAlbumId,
    );

    // Fetching the gallery new album
    final freshResult = await getGalleryNewUseCase(param);

    // dev.log(
    //   'AlbumBloc._getGalleryNewAlbum: '
    //   'Fetched gallery new album with params: $freshResult',
    //   name: 'AlbumBloc',
    // );

    // Emitting the result
    freshResult.fold(
      (failure) {
        // Check if it's the specific offline-no-cache failure
        if (failure is NetworkFailure &&
            failure.message == 'Album not cached locally') {
          Fluttertoast.showToast(
            msg: 'Album not available offline. Please connect to the internet.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
        if (state is! AlbumLoaded) {
          emit(AlbumError(message: failure.message));
        }
      },
      (entity) {
        emit(AlbumLoaded(getGalleryNewEntity: entity));
      },
    );
  }

  void _downloadGallery(DownloadAlbum event, Emitter<AlbumState> emit) async {
    try {
      final dio = Dio();

      // Extract filename from URL
      final tempDir = await getTemporaryDirectory();
      final fileName = event.fileUrl.split('/').last;
      final tempFilePath = '${tempDir.path}/$fileName';
      final file = File(tempFilePath);

      dev.log(file.toString(), name: 'download-gallery');

      // Check if file already exists
      if (await file.exists()) {
        emit(
          AlbumDownloadState(
            progress: 100,
            isComplete: true,
            isShare: event.isShare,
            fileName: fileName,
            filePath: tempFilePath,
          ),
        );
        return; // Skip download
      }

      emit(AlbumDownloadState(progress: 0, fileName: fileName));

      await dio.download(
        event.fileUrl,
        tempFilePath,
        onReceiveProgress: (count, total) {
          if (total > 0) {
            final progress = (count / total) * 100;
            // Dispatch progress event to update UI immediately
            add(UpdateDownloadProgress(progress, isShare: event.isShare));
          }
        },
      );

      final result = await SaverGallery.saveFile(
        filePath: tempFilePath,
        fileName: fileName,
        androidRelativePath: 'DCIM/MyCoAlbum',
        skipIfExists: true,
      );
      final bool isSuccess = result.isSuccess;

      if (isSuccess) {
        dev.log('Successfully saved to gallery');
        emit(
          AlbumDownloadState(
            progress: 100,
            isComplete: true,
            isShare: event.isShare,
            fileName: fileName,
            filePath: tempFilePath,
          ),
        );
      } else {
        emit(const AlbumError(message: 'Failed to save file to gallery.'));
        throw Exception('Failed to save file to gallery.');
      }
    } catch (e) {
      emit(AlbumError(message: 'Download failed: $e'));
    }
  }

  void _updateDownloadProgress(
    UpdateDownloadProgress event,
    Emitter<AlbumState> emit,
  ) {
    emit(AlbumDownloadState(progress: event.progress, isShare: event.isShare));
  }
}
