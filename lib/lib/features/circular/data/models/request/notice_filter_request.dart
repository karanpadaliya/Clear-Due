class NoticeFilterRequest {
  final String? tag;
  final String? unitId;
  final String? userId;
  final String? floorId;
  final String? blockId;
  final String? companyId;
  final String? languageId;
  final String? filterType;
  final String? fromDate;
  final String? toDate;

  const NoticeFilterRequest({
    this.tag,
    this.unitId,
    this.userId,
    this.floorId,
    this.blockId,
    this.companyId,
    this.languageId,
    this.filterType,
    this.fromDate,
    this.toDate,
  });

  Map<String, dynamic> toJson() => {
    'getNoticeFilter': tag,
    'unit_id': unitId,
    'user_id': userId,
    'floor_id': floorId,
    'block_id': blockId,
    'society_id': companyId,
    'language_id': languageId,
    'filter_type': filterType,
    'from_date': fromDate,
    'to_date': toDate
  };
}