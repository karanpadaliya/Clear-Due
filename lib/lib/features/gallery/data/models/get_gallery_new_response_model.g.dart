// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_gallery_new_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetGalleryNewResponseModelAdapter
    extends TypeAdapter<GetGalleryNewResponseModel> {
  @override
  final int typeId = 22;

  @override
  GetGalleryNewResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetGalleryNewResponseModel(
      images: (fields[0] as List?)?.cast<GalleryImage>(),
      message: fields[1] as String?,
      status: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GetGalleryNewResponseModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.images)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetGalleryNewResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GalleryImageAdapter extends TypeAdapter<GalleryImage> {
  @override
  final int typeId = 23;

  @override
  GalleryImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GalleryImage(
      galleryId: fields[0] as String?,
      galleryTitle: fields[1] as String?,
      galleryPhoto: fields[2] as String?,
      galleryType: fields[3] as String?,
      imageSize: fields[4] as String?,
      eventId: fields[5] as String?,
      gallaryGroupId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GalleryImage obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.galleryId)
      ..writeByte(1)
      ..write(obj.galleryTitle)
      ..writeByte(2)
      ..write(obj.galleryPhoto)
      ..writeByte(3)
      ..write(obj.galleryType)
      ..writeByte(4)
      ..write(obj.imageSize)
      ..writeByte(5)
      ..write(obj.eventId)
      ..writeByte(6)
      ..write(obj.gallaryGroupId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGalleryNewResponseModel _$GetGalleryNewResponseModelFromJson(
  Map<String, dynamic> json,
) => GetGalleryNewResponseModel(
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => GalleryImage.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$GetGalleryNewResponseModelToJson(
  GetGalleryNewResponseModel instance,
) => <String, dynamic>{
  'images': instance.images,
  'message': instance.message,
  'status': instance.status,
};

GalleryImage _$GalleryImageFromJson(Map<String, dynamic> json) => GalleryImage(
  galleryId: json['gallery_id'] as String?,
  galleryTitle: json['gallery_title'] as String?,
  galleryPhoto: json['gallery_photo'] as String?,
  galleryType: json['gallery_type'] as String?,
  imageSize: json['image_size'] as String?,
  eventId: json['event_id'] as String?,
  gallaryGroupId: json['gallary_group_id'] as String?,
);

Map<String, dynamic> _$GalleryImageToJson(GalleryImage instance) =>
    <String, dynamic>{
      'gallery_id': instance.galleryId,
      'gallery_title': instance.galleryTitle,
      'gallery_photo': instance.galleryPhoto,
      'gallery_type': instance.galleryType,
      'image_size': instance.imageSize,
      'event_id': instance.eventId,
      'gallary_group_id': instance.gallaryGroupId,
    };
