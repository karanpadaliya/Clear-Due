class GetEmployeeDetailEntity {
  final List<EmployeeEntity>? employees;
  final String? message;
  final String? status;

  GetEmployeeDetailEntity({this.employees, this.message, this.status});
}

class EmployeeEntity {
  final String? userId;
  final String? unitId;
  final String? blockId;
  final String? floorId;
  final String? userFirstName;
  final String? userLastName;
  final String? userMobile;
  final String? userFullName;
  final String? societyId;
  final String? designation;
  final String? shortName;
  final String? userProfilePic;

  EmployeeEntity({
    this.userId,
    this.unitId,
    this.blockId,
    this.floorId,
    this.userFirstName,
    this.userLastName,
    this.userMobile,
    this.userFullName,
    this.societyId,
    this.designation,
    this.shortName,
    this.userProfilePic,
  });
}
