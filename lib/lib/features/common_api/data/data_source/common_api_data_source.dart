import 'package:myco_flutter/features/common_api/data/models/request/branch_list_request.dart';
import 'package:myco_flutter/features/common_api/data/models/request/department_and_designation_list_request.dart';
import 'package:myco_flutter/features/common_api/data/models/request/get_all_employee_request.dart';
import 'package:myco_flutter/features/common_api/data/models/request/shift_list_request.dart';
import 'package:myco_flutter/features/common_api/data/models/response/branch_response.dart';
import 'package:myco_flutter/features/common_api/data/models/response/department_and_designation_response.dart';
import 'package:myco_flutter/features/common_api/data/models/response/get_all_employee_response_model.dart';
import 'package:myco_flutter/features/common_api/data/models/response/shift_response.dart';
import 'package:myco_flutter/features/common_api/data/models/response/uploaded_file_response.dart';

abstract class CommonApiDataSource {
  Future<UploadFileResponseModel> uploadAttachments(
    bool loginType,
    List<String> filePath,
  );

  Future<BranchResponseModel> getBranchList(BranchListRequest request);

  Future<DepartmentAndDesignationResponseModel> getDepartmentAndDesignation(
    DepartmentAndDesignationListRequest request,
  );

  Future<ShiftResponseModel> getShiftList(ShiftListRequest request);

  Future<GetAllEmployeeResponseModel> getAllEmployee(
    GetAllEmployeeRequest request,
  );
}
