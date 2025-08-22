// To parse this JSON data, do
//
//     final galleryAlbumResponseModel = galleryAlbumResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/dashboard/data/models/my_unit_response.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/gallery/domain/entities/gallery_album_entity.dart';

part 'gallery_album_response_model.g.dart';

GalleryAlbumResponseModel galleryAlbumResponseModelFromJson(String str) =>
    GalleryAlbumResponseModel.fromJson(json.decode(str));

String galleryAlbumResponseModelToJson(GalleryAlbumResponseModel data) =>
    json.encode(data.toJson());

@HiveType(typeId: 24)
@JsonSerializable()
class GalleryAlbumResponseModel {
  @HiveField(0)
  @JsonKey(name: 'event_album')
  List<EventAlbum>? eventAlbum;
  @HiveField(1)
  @JsonKey(name: 'message')
  String? message;
  @HiveField(3)
  @JsonKey(name: 'status')
  String? status;

  GalleryAlbumResponseModel({this.eventAlbum, this.message, this.status});

  factory GalleryAlbumResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryAlbumResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryAlbumResponseModelToJson(this);

  /// Converts the data model to a domain entity.
  GalleryAlbumEntity toEntity() => GalleryAlbumEntity(
    eventAlbum: eventAlbum?.map((model) => model.toEntity()).toList(),
    message: message,
    status: status,

  );
}

// @HiveType(typeId: 25)
// @JsonSerializable()
// class EventAlbum {
//   @HiveField(0)
//   @JsonKey(name: 'gallery_album_id')
//   String? galleryAlbumId;
//   @HiveField(1)
//   @JsonKey(name: 'album_title')
//   String? albumTitle;
//   @HiveField(2)
//   @JsonKey(name: 'event_id')
//   String? eventId;
//   @HiveField(3)
//   @JsonKey(name: 'event_date')
//   DateTime? eventDate;
//   @HiveField(4)
//   @JsonKey(name: 'block_id')
//   String? blockId;
//   @HiveField(5)
//   @JsonKey(name: 'floor_id')
//   String? floorId;
//   @HiveField(6)
//   @JsonKey(name: 'upload_date')
//   String? uploadDate;
  // @HiveField(7)
  // @JsonKey(name: 'images')
  // List<AlbumImage>? images;

//   EventAlbum({
//     this.galleryAlbumId,
//     this.albumTitle,
//     this.eventId,
//     this.eventDate,
//     this.blockId,
//     this.floorId,
//     this.uploadDate,
//     this.images,
//   });

//   factory EventAlbum.fromJson(Map<String, dynamic> json) =>
//       _$EventAlbumFromJson(json);

//   Map<String, dynamic> toJson() => _$EventAlbumToJson(this);

//   /// Converts the data model to a domain entity.
//   EventAlbumEntity toEntity() => EventAlbumEntity(
//     galleryAlbumId: galleryAlbumId,
//     albumTitle: albumTitle,
//     eventId: eventId,
//     eventDate: eventDate,
//     blockId: blockId,
//     floorId: floorId,
//     uploadDate: uploadDate,
//     images: images?.map((model) => model.toEntity()).toList(),
//   );
// }

@HiveType(typeId: 25)
@JsonSerializable()
class AlbumImage {
  @HiveField(0)
  @JsonKey(name: 'gallery_id')
  String? galleryId;
  @HiveField(1)
  @JsonKey(name: 'gallery_type')
  String? galleryType;
  @HiveField(2)
  @JsonKey(name: 'gallery_photo')
  String? galleryPhoto;

  AlbumImage({this.galleryId, this.galleryType, this.galleryPhoto});

  factory AlbumImage.fromJson(Map<String, dynamic> json) =>
      _$AlbumImageFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumImageToJson(this);

  /// Converts the data model to a domain entity.
  ImageEntity toEntity() => ImageEntity(
    galleryId: galleryId,
    galleryType: galleryType,
    galleryPhoto: galleryPhoto,
  );
}
