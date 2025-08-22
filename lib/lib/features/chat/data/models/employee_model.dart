import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/chat/domain/entities/all_departments_entities.dart';
import 'package:myco_flutter/features/chat/domain/entities/all_employee_entity.dart'  hide DepartmentEntity;


class EmployeeSelectModel extends Equatable {
  final String id;
  final String name;
  final String department;
  final String departmentId;
  final String imageUrl;
  final bool isSelected;

  const EmployeeSelectModel({
    required this.id,
    required this.name,
    required this.department,
    required this.departmentId, 
    required this.imageUrl,
    this.isSelected = false,
  });
   factory EmployeeSelectModel.fromMember(EmployeeEntity apiModel) => EmployeeSelectModel(
      id: apiModel.userId ,
      name: apiModel.userFirstName ,
      department: apiModel.departmentName ,
      departmentId: apiModel.floorId ,
      imageUrl: apiModel.userProfilePic   ,
      isSelected: false, // Default value
    );
  EmployeeSelectModel copyWith({bool? isSelected}) => EmployeeSelectModel(
      id: id,
      name: name,
      department: department,
      departmentId: departmentId,
      imageUrl: imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );

  @override
  List<Object?> get props => [id, name, department,departmentId, imageUrl, isSelected];
}


class Department {
  final String id;
  final String name;
  final String? blockId;

  Department({
    required this.id,
    required this.name,
    this.blockId,
  });

  factory Department.fromJson(DepartmentEntity json) {
    return Department(
      id: json.floorId ?? '',
      name: json.departmentName ?? '',
      blockId: json.blockId ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Department && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}