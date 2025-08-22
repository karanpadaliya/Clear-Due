// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wfh_data_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WFHDataResponseAdapter extends TypeAdapter<WFHDataResponse> {
  @override
  final int typeId = 11;

  @override
  WFHDataResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WFHDataResponse(
      wfhId: fields[0] as String?,
      wfhStartDate: fields[1] as String?,
      wfhLatitude: fields[2] as String?,
      wfhLongitude: fields[3] as String?,
      wfhAttendanceRange: fields[4] as String?,
      wfhTakeSelfie: fields[5] as String?,
      wfhAddress: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WFHDataResponse obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.wfhId)
      ..writeByte(1)
      ..write(obj.wfhStartDate)
      ..writeByte(2)
      ..write(obj.wfhLatitude)
      ..writeByte(3)
      ..write(obj.wfhLongitude)
      ..writeByte(4)
      ..write(obj.wfhAttendanceRange)
      ..writeByte(5)
      ..write(obj.wfhTakeSelfie)
      ..writeByte(6)
      ..write(obj.wfhAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WFHDataResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WFHDataResponse _$WFHDataResponseFromJson(Map<String, dynamic> json) =>
    WFHDataResponse(
      wfhId: json['wfh_id'] as String?,
      wfhStartDate: json['wfh_start_date'] as String?,
      wfhLatitude: json['wfh_latitude'] as String?,
      wfhLongitude: json['wfh_longitude'] as String?,
      wfhAttendanceRange: json['wfh_attendance_range'] as String?,
      wfhTakeSelfie: json['wfh_take_selfie'] as String?,
      wfhAddress: json['wfh_address'] as String?,
    );

Map<String, dynamic> _$WFHDataResponseToJson(WFHDataResponse instance) =>
    <String, dynamic>{
      'wfh_id': instance.wfhId,
      'wfh_start_date': instance.wfhStartDate,
      'wfh_latitude': instance.wfhLatitude,
      'wfh_longitude': instance.wfhLongitude,
      'wfh_attendance_range': instance.wfhAttendanceRange,
      'wfh_take_selfie': instance.wfhTakeSelfie,
      'wfh_address': instance.wfhAddress,
    };
