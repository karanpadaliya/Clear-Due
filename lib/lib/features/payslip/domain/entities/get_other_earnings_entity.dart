class GetOtherEarningsEntity {
  final List<OtherEarningEntity>? otherEarnings;
  final String? totalEarnings;
  final String? message;
  final String? status;

  GetOtherEarningsEntity({
    this.otherEarnings,
    this.totalEarnings,
    this.message,
    this.status,
  });
}

class OtherEarningEntity {
  final String? leavePayoutId;
  final String? leaveTypeId;
  final String? leaveTypeName;
  final String? noOfPayoutLeaves;
  final String? leavePayoutAmount;
  final String? leavePayoutRemark;
  final String? leavePayoutDate;

  OtherEarningEntity({
    this.leavePayoutId,
    this.leaveTypeId,
    this.leaveTypeName,
    this.noOfPayoutLeaves,
    this.leavePayoutAmount,
    this.leavePayoutRemark,
    this.leavePayoutDate,
  });
}
