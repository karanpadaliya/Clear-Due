import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/gallery/domain/entities/get_gallery_new_entity.dart';

part 'get_gallery_new_response_model.g.dart';

GetGalleryNewResponseModel getGalleryNewResponseModelFromJson(String str) =>
    GetGalleryNewResponseModel.fromJson(json.decode(str));

String getGalleryNewResponseModelToJson(GetGalleryNewResponseModel data) =>
    json.encode(data.toJson());

@HiveType(typeId: 22)
@JsonSerializable()
class GetGalleryNewResponseModel {
  @HiveField(0)
  @JsonKey(name: 'images')
  List<GalleryImage>? images;
  @HiveField(1)
  @JsonKey(name: 'message')
  String? message;
  @HiveField(2)
  @JsonKey(name: 'status')
  String? status;

  GetGalleryNewResponseModel({this.images, this.message, this.status});

  factory GetGalleryNewResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetGalleryNewResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetGalleryNewResponseModelToJson(this);

  // to entity
  GetGalleryNewEntity toEntity() => GetGalleryNewEntity(
    images: images?.map((image) => image.toEntity()).toList(),
    message: message,
    status: status,
  );
}

@HiveType(typeId: 23)
@JsonSerializable()
class GalleryImage {
  @HiveField(0)
  @JsonKey(name: 'gallery_id')
  String? galleryId;
  @HiveField(1)
  @JsonKey(name: 'gallery_title')
  String? galleryTitle;
  @HiveField(2)
  @JsonKey(name: 'gallery_photo')
  String? galleryPhoto;
  @HiveField(3)
  @JsonKey(name: 'gallery_type')
  String? galleryType;
  @HiveField(4)
  @JsonKey(name: 'image_size')
  String? imageSize;
  @HiveField(5)
  @JsonKey(name: 'event_id')
  String? eventId;
  @HiveField(6)
  @JsonKey(name: 'gallary_group_id')
  String? gallaryGroupId;

  GalleryImage({
    this.galleryId,
    this.galleryTitle,
    this.galleryPhoto,
    this.galleryType,
    this.imageSize,
    this.eventId,
    this.gallaryGroupId,
  });

  factory GalleryImage.fromJson(Map<String, dynamic> json) =>
      _$GalleryImageFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryImageToJson(this);

  // to entity
  ImageEntity toEntity() => ImageEntity(
    galleryId: galleryId,
    galleryTitle: galleryTitle,
    galleryPhoto: galleryPhoto,
    galleryType: galleryType,
    imageSize: imageSize,
    eventId: eventId,
    galleryGroupId: gallaryGroupId,
  );
}
