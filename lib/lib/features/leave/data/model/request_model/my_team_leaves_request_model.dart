class MyTeamLeavesRequestModel {
  final String action; // getMyTeamLeaves
  final String societyId;
  final String userId;
  final String languageId;
  final String limit;
  final String levelId;

  MyTeamLeavesRequestModel({
    required this.societyId,
    required this.userId,
    required this.levelId,
    this.action = 'getMyTeamLeaves',
    this.languageId = '1',
    this.limit = '',
  });

  Map<String, String> toMap() => {
    'getMyTeamLeaves': action,
    'society_id': societyId,
    'user_id': userId,
    'language_id': languageId,
    'limit': limit,
    'level_id': levelId,
  };
}
