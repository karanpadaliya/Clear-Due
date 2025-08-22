import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/common_api/data/models/request/branch_list_request.dart';
import 'package:myco_flutter/features/common_api/data/models/request/department_and_designation_list_request.dart';
import 'package:myco_flutter/features/common_api/data/models/request/get_all_employee_request.dart';
import 'package:myco_flutter/features/common_api/data/models/request/shift_list_request.dart';
import 'package:myco_flutter/features/common_api/domain/entities/Branch_response_entity.dart';
import 'package:myco_flutter/features/common_api/domain/entities/department_and_designation_response_entity.dart';
import 'package:myco_flutter/features/common_api/domain/entities/get_all_employee_response_entity.dart';
import 'package:myco_flutter/features/common_api/domain/entities/shift_response_entity.dart';
import 'package:myco_flutter/features/common_api/domain/entities/uploaded_file_response_entity.dart';

abstract class CommonApiRepository {
  Future<Either<Failure, UploadFileResponseEntity>> uploadAttachments(
    bool loginType,
    List<String> filePath,
  );

  Future<Either<Failure, BranchResponseEntity>> getBranchList(
    BranchListRequest request,
  );

  Future<Either<Failure, DepartmentAndDesignationResponseEntity>>
  getDepartmentAndDesignation(DepartmentAndDesignationListRequest request);

  Future<Either<Failure, ShiftResponseEntity>> getShiftList(
    ShiftListRequest request,
  );

  Future<Either<Failure, GetAllEmployeeResponseEntity>> getAllEmployee(
    GetAllEmployeeRequest request,
  );
}