import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String? userId;
  final String? unitId;
  final String? branchId;
  final String? departmentId;
  final String? userFirstName;
  final String? userLastName;
  final String? userMobile;
  final String? userFullName;
  final String? shortName;
  final String? companyId;
  final String? designation;
  final String? companyLeaveDate;
  final String? companyLeaveDateView;
  final bool? isFutureDate;
  final bool? userActive;
  final String? userProfilePic;

  const Employee({
    this.userId,
    this.unitId,
    this.branchId,
    this.departmentId,
    this.userFirstName,
    this.userLastName,
    this.userMobile,
    this.userFullName,
    this.shortName,
    this.companyId,
    this.designation,
    this.companyLeaveDate,
    this.companyLeaveDateView,
    this.isFutureDate,
    this.userActive,
    this.userProfilePic,
  });

  @override
  List<Object?> get props => [
    userId,
    unitId,
    branchId,
    departmentId,
    userFirstName,
    userLastName,
    userMobile,
    userFullName,
    shortName,
    companyId,
    designation,
    companyLeaveDate,
    companyLeaveDateView,
    isFutureDate,
    userActive,
    userProfilePic,
  ];
}
