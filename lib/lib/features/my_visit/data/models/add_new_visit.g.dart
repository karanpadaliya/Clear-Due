// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewVisitResponseModel _$AddNewVisitResponseModelFromJson(
  Map<String, dynamic> json,
) => AddNewVisitResponseModel(
  visitId: (json['visit_id'] as num?)?.toInt(),
  message: json['message'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$AddNewVisitResponseModelToJson(
  AddNewVisitResponseModel instance,
) => <String, dynamic>{
  'visit_id': instance.visitId,
  'message': instance.message,
  'status': instance.status,
};
