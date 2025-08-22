// To parse this JSON data, do
//
//     final addAssetUserModel = addAssetUserModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:myco_flutter/features/asset/domain/entities/add_asset_user_entity.dart';

part 'add_asset_user_model.g.dart';

AddAssetUserModel addAssetUserModelFromJson(String str) => AddAssetUserModel.fromJson(json.decode(str));

String addAssetUserModelToJson(AddAssetUserModel data) => json.encode(data.toJson());

@JsonSerializable()
class AddAssetUserModel {
    @JsonKey(name: "employees")
    List<Employee>? employees;
    @JsonKey(name: "message")
    String? message;

    AddAssetUserModel({
        this.employees,
        this.message,
    });

    factory AddAssetUserModel.fromJson(Map<String, dynamic> json) => _$AddAssetUserModelFromJson(json);

    Map<String, dynamic> toJson() => _$AddAssetUserModelToJson(this);
}

@JsonSerializable()
class Employee {
    @JsonKey(name: "user_id")
    String? userId;
    @JsonKey(name: "block_id")
    String? blockId;
    @JsonKey(name: "floor_id")
    String? floorId;
    @JsonKey(name: "user_first_name")
    String? userFirstName;
    @JsonKey(name: "user_last_name")
    String? userLastName;
    @JsonKey(name: "user_mobile")
    String? userMobile;
    @JsonKey(name: "user_full_name")
    String? userFullName;
    @JsonKey(name: "society_id")
    String? societyId;
    @JsonKey(name: "designation")
    String? designation;
    @JsonKey(name: "short_name")
    String? shortName;
    @JsonKey(name: "user_profile_pic")
    String? userProfilePic;

    Employee({
        this.userId,
        this.blockId,
        this.floorId,
        this.userFirstName,
        this.userLastName,
        this.userMobile,
        this.userFullName,
        this.societyId,
        this.designation,
        this.shortName,
        this.userProfilePic,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

    Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

extension AddAssetUserModelMapper on AddAssetUserModel {
  AddAssetUserEntity toEntity() => AddAssetUserEntity(
        employees: employees?.map((e) => e.toEntity()).toList(),
        message: message,
      );
}

extension EmployeeModelMapper on Employee {
  EmployeeEntity toEntity() => EmployeeEntity(
        userId: userId,
        blockId: blockId,
        floorId: floorId,
        userFirstName: userFirstName,
        userLastName: userLastName,
        userMobile: userMobile,
        userFullName: userFullName,
        societyId: societyId,
        designation: designation,
        shortName: shortName,
        userProfilePic: userProfilePic,
      );
}
