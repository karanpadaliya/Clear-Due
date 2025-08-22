import 'package:myco_flutter/features/work_from_home/data/models/admin_req_wfh/req_wfh_model.dart';
import 'package:myco_flutter/features/work_from_home/data/models/admin_req_wfh/req_wfh_request_model.dart';

abstract class AdminReqWfhDataSource {
  Future<AdminWfhResponse> getAllReqWfh(GetAdminWfhRequestModel request);

  Future<AdminWfhResponse> approveWfhRequest(
    AdminWfhApproveRequestModel request,
  );

  Future<AdminWfhResponse> rejectWfhRequest(AdminWfhRejectRequestModel request);
}
