// To parse this JSON data, do
//
//     final achievementEducationModel = achievementEducationModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/achievement_education_entity.dart';

part 'achievement_education_model.g.dart';

AchievementEducationModel achievementEducationModelFromJson(String str) => AchievementEducationModel.fromJson(json.decode(str));

String achievementEducationModelToJson(AchievementEducationModel data) => json.encode(data.toJson());

@JsonSerializable()
class AchievementEducationModel {
  @JsonKey(name: 'achievement')
  List<Achievement>? achievement;
  @JsonKey(name: 'education')
  List<Achievement>? education;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'status')
  String? status;

  AchievementEducationModel({
    this.achievement,
    this.education,
    this.message,
    this.status,
  });

  factory AchievementEducationModel.fromJson(Map<String, dynamic> json) => _$AchievementEducationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementEducationModelToJson(this);

  AchievementEducationEntity toEntity()=> AchievementEducationEntity(
    achievement: achievement?.map((e) => AchievementEntity(
      employeeAchievementId: e.employeeAchievementId,
      achievementName: e.achievementName,
      achievementDate: e.achievementDate,
      universityBoardName: e.universityBoardName,
      archiType: e.archiType,
    )).toList(),
    education: education?.map((e) => AchievementEntity(
      employeeAchievementId: e.employeeAchievementId,
      achievementName: e.achievementName,
      achievementDate: e.achievementDate,
      universityBoardName: e.universityBoardName,
      archiType: e.archiType,
    )).toList(),
    message: message,
    status: status,
  );
}

@JsonSerializable()
class Achievement {
  @JsonKey(name: 'employee_achievement_id')
  String? employeeAchievementId;
  @JsonKey(name: 'achievement_name')
  String? achievementName;
  @JsonKey(name: 'achievement_date')
  DateTime? achievementDate;
  @JsonKey(name: 'university_board_name')
  String? universityBoardName;
  @JsonKey(name: 'archi_type')
  String? archiType;

    Achievement({
    this.employeeAchievementId,
    this.achievementName,
    this.achievementDate,
    this.universityBoardName,
    this.archiType,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementToJson(this);

  AchievementEntity toEntity() => AchievementEntity(
    employeeAchievementId: employeeAchievementId,
    achievementName: achievementName,
    achievementDate: achievementDate,
    universityBoardName: universityBoardName,
    archiType: archiType,
  );
}
