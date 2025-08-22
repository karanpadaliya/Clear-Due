// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_activity_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetActivityResponseModel _$GetActivityResponseModelFromJson(
  Map<String, dynamic> json,
) => GetActivityResponseModel(
  viewClearButton: json['view_clear_button'] as bool?,
  logname:
      (json['logname'] as List<dynamic>?)
          ?.map((e) => Logname.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$GetActivityResponseModelToJson(
  GetActivityResponseModel instance,
) => <String, dynamic>{
  'view_clear_button': instance.viewClearButton,
  'logname': instance.logname,
  'message': instance.message,
  'status': instance.status,
};

Logname _$LognameFromJson(Map<String, dynamic> json) => Logname(
  logId: json['log_id'] as String?,
  userId: json['user_id'] as String?,
  logName: json['log_name'] as String?,
  logImage: json['log_image'] as String?,
  logTime: json['log_time'] as String?,
);

Map<String, dynamic> _$LognameToJson(Logname instance) => <String, dynamic>{
  'log_id': instance.logId,
  'user_id': instance.userId,
  'log_name': instance.logName,
  'log_image': instance.logImage,
  'log_time': instance.logTime,
};
