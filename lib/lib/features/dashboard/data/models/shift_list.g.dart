// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShiftListAdapter extends TypeAdapter<ShiftList> {
  @override
  final int typeId = 10;

  @override
  ShiftList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShiftList(
      shiftTimeId: fields[0] as String?,
      shiftName: fields[1] as String?,
      shiftTimeZone: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ShiftList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.shiftTimeId)
      ..writeByte(1)
      ..write(obj.shiftName)
      ..writeByte(2)
      ..write(obj.shiftTimeZone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftList _$ShiftListFromJson(Map<String, dynamic> json) => ShiftList(
  shiftTimeId: json['shift_time_id'] as String?,
  shiftName: json['shift_name'] as String?,
  shiftTimeZone: json['shift_time_zone'] as String?,
);

Map<String, dynamic> _$ShiftListToJson(ShiftList instance) => <String, dynamic>{
  'shift_time_id': instance.shiftTimeId,
  'shift_name': instance.shiftName,
  'shift_time_zone': instance.shiftTimeZone,
};
