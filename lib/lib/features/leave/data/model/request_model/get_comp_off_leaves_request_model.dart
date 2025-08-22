// 📄 File: get_comp_off_leaves_request_model.dart
class GetCompOffLeavesRequestModel {
  final String action; // getCompOffLeaves
  final String societyId;
  final String userId;
  final String languageId;
  final String startDate;
  final String endDate;

  GetCompOffLeavesRequestModel({
    this.action = 'getCompOffLeaves',
    required this.societyId,
    required this.userId,
    this.languageId = '1',
    required this.startDate,
    required this.endDate,
  });

  Map<String, String> toMap() {
    return {
      'getCompOffLeaves': action,
      'society_id': societyId,
      'user_id': userId,
      'language_id': languageId,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
