import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/get_activity_response_entity.dart';

part 'get_activity_response_model.g.dart';

GetActivityResponseModel getActivityResponseFromJson(String str) =>
    GetActivityResponseModel.fromJson(json.decode(str));

String getActivityResponseToJson(GetActivityResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetActivityResponseModel {
  @JsonKey(name: 'view_clear_button')
  bool? viewClearButton;

  @JsonKey(name: 'logname')
  List<Logname>? logname;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'status')
  String? status;

  GetActivityResponseModel({
    this.viewClearButton,
    this.logname,
    this.message,
    this.status,
  });

  factory GetActivityResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetActivityResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetActivityResponseModelToJson(this);

  GetActivityResponseEntity toEntity() => GetActivityResponseEntity(
    viewClearButton: viewClearButton,
    logname: logname?.map((e) => e.toEntity()).toList(),
    message: message,
    status: status,
  );
}

@JsonSerializable()
class Logname {
  @JsonKey(name: 'log_id')
  String? logId;

  @JsonKey(name: 'user_id')
  String? userId;

  @JsonKey(name: 'log_name')
  String? logName;

  @JsonKey(name: 'log_image')
  String? logImage;

  @JsonKey(name: 'log_time')
  String? logTime;

  Logname({this.logId, this.userId, this.logName, this.logImage, this.logTime});

  factory Logname.fromJson(Map<String, dynamic> json) =>
      _$LognameFromJson(json);

  Map<String, dynamic> toJson() => _$LognameToJson(this);

  LognameEntity toEntity() => LognameEntity(
    logId: logId,
    userId: userId,
    logName: logName,
    logImage: logImage,
    logTime: logTime,
  );
}
