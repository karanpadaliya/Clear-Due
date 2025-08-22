// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_education_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementEducationModel _$AchievementEducationModelFromJson(
  Map<String, dynamic> json,
) => AchievementEducationModel(
  achievement:
      (json['achievement'] as List<dynamic>?)
          ?.map((e) => Achievement.fromJson(e as Map<String, dynamic>))
          .toList(),
  education:
      (json['education'] as List<dynamic>?)
          ?.map((e) => Achievement.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$AchievementEducationModelToJson(
  AchievementEducationModel instance,
) => <String, dynamic>{
  'achievement': instance.achievement,
  'education': instance.education,
  'message': instance.message,
  'status': instance.status,
};

Achievement _$AchievementFromJson(Map<String, dynamic> json) => Achievement(
  employeeAchievementId: json['employee_achievement_id'] as String?,
  achievementName: json['achievement_name'] as String?,
  achievementDate:
      json['achievement_date'] == null
          ? null
          : DateTime.parse(json['achievement_date'] as String),
  universityBoardName: json['university_board_name'] as String?,
  archiType: json['archi_type'] as String?,
);

Map<String, dynamic> _$AchievementToJson(Achievement instance) =>
    <String, dynamic>{
      'employee_achievement_id': instance.employeeAchievementId,
      'achievement_name': instance.achievementName,
      'achievement_date': instance.achievementDate?.toIso8601String(),
      'university_board_name': instance.universityBoardName,
      'archi_type': instance.archiType,
    };
