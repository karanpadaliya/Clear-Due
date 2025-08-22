import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/myvisit_entity.dart';

part 'add_new_visit.g.dart';

AddNewVisitResponseModel addNewVisitFromJson(String str) =>
    AddNewVisitResponseModel.fromJson(json.decode(str));

String addNewVisitToJson(AddNewVisitResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AddNewVisitResponseModel {
  @JsonKey(name: 'visit_id')
  int? visitId;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'status')
  String? status;

  AddNewVisitResponseModel({this.visitId, this.message, this.status});

  factory AddNewVisitResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddNewVisitResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddNewVisitResponseModelToJson(this);
  AddNewVisitEntity toEntity() =>
      AddNewVisitEntity(visitId: visitId, message: message, status: status);
}
