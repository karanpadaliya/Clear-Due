// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_album_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GalleryAlbumResponseModelAdapter
    extends TypeAdapter<GalleryAlbumResponseModel> {
  @override
  final int typeId = 24;

  @override
  GalleryAlbumResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GalleryAlbumResponseModel(
      eventAlbum: (fields[0] as List?)?.cast<EventAlbum>(),
      message: fields[1] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GalleryAlbumResponseModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.eventAlbum)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryAlbumResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AlbumImageAdapter extends TypeAdapter<AlbumImage> {
  @override
  final int typeId = 25;

  @override
  AlbumImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumImage(
      galleryId: fields[0] as String?,
      galleryType: fields[1] as String?,
      galleryPhoto: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AlbumImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.galleryId)
      ..writeByte(1)
      ..write(obj.galleryType)
      ..writeByte(2)
      ..write(obj.galleryPhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryAlbumResponseModel _$GalleryAlbumResponseModelFromJson(
  Map<String, dynamic> json,
) => GalleryAlbumResponseModel(
  eventAlbum:
      (json['event_album'] as List<dynamic>?)
          ?.map((e) => EventAlbum.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$GalleryAlbumResponseModelToJson(
  GalleryAlbumResponseModel instance,
) => <String, dynamic>{
  'event_album': instance.eventAlbum,
  'message': instance.message,
  'status': instance.status,
};

AlbumImage _$AlbumImageFromJson(Map<String, dynamic> json) => AlbumImage(
  galleryId: json['gallery_id'] as String?,
  galleryType: json['gallery_type'] as String?,
  galleryPhoto: json['gallery_photo'] as String?,
);

Map<String, dynamic> _$AlbumImageToJson(AlbumImage instance) =>
    <String, dynamic>{
      'gallery_id': instance.galleryId,
      'gallery_type': instance.galleryType,
      'gallery_photo': instance.galleryPhoto,
    };
