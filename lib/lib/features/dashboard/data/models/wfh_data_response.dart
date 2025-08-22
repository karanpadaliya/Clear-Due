import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/wfh_data_response_entity.dart';

part 'wfh_data_response.g.dart';

WFHDataResponse wfhDataResponseFromJson(String str) =>
    WFHDataResponse.fromJson(json.decode(str));

String wfhDataResponseToJson(WFHDataResponse data) =>
    json.encode(data.toJson());

@HiveType(typeId: 11) // Assign a new unique typeId
@JsonSerializable()
class WFHDataResponse {
  @HiveField(0)
  @JsonKey(name: "wfh_id")
  String? wfhId;
  @HiveField(1)
  @JsonKey(name: "wfh_start_date")
  String? wfhStartDate;
  @HiveField(2)
  @JsonKey(name: "wfh_latitude")
  String? wfhLatitude;
  @HiveField(3)
  @JsonKey(name: "wfh_longitude")
  String? wfhLongitude;
  @HiveField(4)
  @JsonKey(name: "wfh_attendance_range")
  String? wfhAttendanceRange;
  @HiveField(5)
  @JsonKey(name: "wfh_take_selfie")
  String? wfhTakeSelfie;
  @HiveField(6)
  @JsonKey(name: "wfh_address")
  String? wfhAddress;

  WFHDataResponse({
    this.wfhId,
    this.wfhStartDate,
    this.wfhLatitude,
    this.wfhLongitude,
    this.wfhAttendanceRange,
    this.wfhTakeSelfie,
    this.wfhAddress,
  });

  factory WFHDataResponse.fromJson(Map<String, dynamic> json) =>
      _$WFHDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WFHDataResponseToJson(this);

  WFHDataResponseEntity toEntity() => WFHDataResponseEntity(
    wfhId: wfhId,
    wfhStartDate: wfhStartDate,
    wfhLatitude: wfhLatitude,
    wfhLongitude: wfhLongitude,
    wfhAttendanceRange: wfhAttendanceRange,
    wfhTakeSelfie: wfhTakeSelfie,
    wfhAddress: wfhAddress,
  );
}
