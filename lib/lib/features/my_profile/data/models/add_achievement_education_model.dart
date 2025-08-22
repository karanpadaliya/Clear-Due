class AddAchievementEducationModel {
  final String employeeAchievementId;
  final String achievementName;
  final String achievementDate;
  final String universityBoardName;
  final String archiType;
  final String view;

  AddAchievementEducationModel({
    required this.employeeAchievementId,
    required this.achievementName,
    required this.achievementDate,
    required this.universityBoardName,
    required this.archiType,
    required this.view,
  });
  Map<String, dynamic> toJson() => {
      'employeeAchievementId': employeeAchievementId,
      'achievementName': achievementName,
      'achievementDate': achievementDate,
      'universityBoardName': universityBoardName,
      'archiType': archiType,
      'view': view,
    };
}
