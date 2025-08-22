class GetAllEmployeeResponseEntity {
  final String? totalEmployee;
  final List<EmployeeEntity>? employees;
  final String? message;
  final String? status;

  const GetAllEmployeeResponseEntity({
    this.totalEmployee,
    this.employees,
    this.message,
    this.status,
  });
}

class EmployeeEntity {
  final String color;
  final bool isEmployeeSelected;
  final bool isAllEmployeeSelected;
  final bool isSelected;
  final String targetAmount;
  final String? branchName;
  final String? companyName;
  final String? unitId;
  final String? blockId;
  final String? floorId;
  final String? userId;
  final bool? isFutureDate;
  final bool? userActive;
  final String? userFirstName;
  final String? userLastName;
  final String? userMobile;
  final String? userFullName;
  final String? societyId;
  final String? designation;
  final String? departmentName;
  final String? userProfilePic;
  final String? shortName;
  final String? colorBackGround;
  final String? floorName;
  final String? blockName;
  final String? userFullNameView;
  final String? userDesignation;

  const EmployeeEntity({
    required this.color,
    required this.isEmployeeSelected,
    required this.isAllEmployeeSelected,
    required this.isSelected,
    required this.targetAmount,
    this.branchName,
    this.companyName,
    this.unitId,
    this.blockId,
    this.floorId,
    this.userId,
    this.isFutureDate,
    this.userActive,
    this.userFirstName,
    this.userLastName,
    this.userMobile,
    this.userFullName,
    this.societyId,
    this.designation,
    this.departmentName,
    this.userProfilePic,
    this.shortName,
    this.colorBackGround,
    this.floorName,
    this.blockName,
    this.userFullNameView,
    this.userDesignation,
  });
}
