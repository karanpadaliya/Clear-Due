class ShiftDetailsRequestModel {
  final String? tag;
  final String? companyId;
  final String? languageId;
  final String? userId;
  final String? shiftTimeId;
  final String? alterShift;

  ShiftDetailsRequestModel({
    this.tag,
    this.companyId,
    this.languageId,
    this.userId,
    this.shiftTimeId,
    this.alterShift,
  });

  Map<String, dynamic> toJson() => {
    'getMyShift': tag,
    'society_id': companyId,
    'language_id': languageId,
    'user_id': userId,
    'shift_time_id': shiftTimeId,
    'alter_shift': alterShift,
  };
}
