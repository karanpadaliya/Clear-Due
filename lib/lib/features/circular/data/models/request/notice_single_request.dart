class NoticeSingleRequest {
  final String? tag;
  final String? unitId;
  final String? userId;
  final String? floorId;
  final String? blockId;
  final String? companyId;
  final String? languageId;
  final String? noticeBoardId;

  const NoticeSingleRequest({
    this.tag,
    this.unitId,
    this.userId,
    this.floorId,
    this.blockId,
    this.companyId,
    this.languageId,
    this.noticeBoardId
  });

  Map<String, dynamic> toJson() => {
    
    'getNoticeSingle': tag,
    'unit_id': unitId,
    'user_id': userId,
    'floor_id': floorId,
    'block_id': blockId,
    'society_id': companyId,
    'language_id': languageId,
    'notice_board_id': noticeBoardId
  };
}