// achievement_education_entity.dart

class AchievementEducationEntity {
  // Domain models contain nullable lists and fields as per your needs
  final List<AchievementEntity>? achievement;
  final List<AchievementEntity>? education;
  final String? message;
  final String? status;

  AchievementEducationEntity({
    this.achievement,
    this.education,
    this.message,
    this.status,
  });
}

class AchievementEntity {
  final String? employeeAchievementId;
  final String? achievementName;
  final DateTime? achievementDate;
  final String? universityBoardName;
  final String? archiType;

  AchievementEntity({
    this.employeeAchievementId,
    this.achievementName,
    this.achievementDate,
    this.universityBoardName,
    this.archiType,
  });
}
