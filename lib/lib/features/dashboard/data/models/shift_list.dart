import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/shift_list_entity.dart';

part 'shift_list.g.dart';

ShiftList shiftListFromJson(String str) => ShiftList.fromJson(json.decode(str));

String shiftListToJson(ShiftList data) => json.encode(data.toJson());

@HiveType(typeId: 10) // Assign a new unique typeId
@JsonSerializable()
class ShiftList {
  @HiveField(0)
  @JsonKey(name: "shift_time_id")
  String? shiftTimeId;
  @HiveField(1)
  @JsonKey(name: "shift_name")
  String? shiftName;
  @HiveField(2)
  @JsonKey(name: "shift_time_zone")
  String? shiftTimeZone;

  ShiftList({
    this.shiftTimeId,
    this.shiftName,
    this.shiftTimeZone,
  });

  factory ShiftList.fromJson(Map<String, dynamic> json) =>
      _$ShiftListFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftListToJson(this);

  ShiftListEntity toEntity() => ShiftListEntity(
    shiftTimeId: shiftTimeId,
    shiftName: shiftName,
    shiftTimeZone: shiftTimeZone,
  );
}