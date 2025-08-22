import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
// This file defines the GalleryAlbumEntity and related entities used in the gallery feature of the application.
class GalleryAlbumEntity extends Equatable {
  final List<EventAlbumEntity>? eventAlbum;
  final String? message;
  final String? status;

  const GalleryAlbumEntity({this.eventAlbum, this.message, this.status});

  @override
  List<Object?> get props => [eventAlbum, message, status];
}

// class EventAlbumEntity  extends Equatable {
//   final String? galleryAlbumId;
//   final String? albumTitle;
//   final String? eventId;
//   final DateTime? eventDate;
//   final String? blockId;
//   final String? floorId;
//   final String? uploadDate;
//   final List<ImageEntity>? images;



//  const EventAlbumEntity({
//     this.galleryAlbumId,
//     this.albumTitle,
//     this.eventId,
//     this.eventDate,
//     this.blockId,
//     this.floorId,
//     this.uploadDate,
//     this.images,
//   });

//   @override
//   List<Object?> get props => [
//     galleryAlbumId,
//     albumTitle,
//     eventId,
//     eventDate,
//     blockId,
//     floorId,
//     uploadDate,
//     images,
//   ];
// }

