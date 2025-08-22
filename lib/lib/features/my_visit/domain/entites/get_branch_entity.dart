class GetBranchEntity {
  final List<BranchEntity> branchList;
  final String message;
  final String status;

  GetBranchEntity({
    required this.branchList,
    required this.message,
    required this.status,
  });
}

class BranchEntity {
  final String blockId;
  final String societyId;
  final String blockName;

  BranchEntity({
    required this.blockId,
    required this.societyId,
    required this.blockName,
  });
}
