import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/encryption/gzip_util.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/work_from_home/data/data_source/admin_req_wfh/req_wfh_data_source.dart';
import 'package:myco_flutter/features/work_from_home/data/models/admin_req_wfh/req_wfh_model.dart';
import 'package:myco_flutter/features/work_from_home/data/models/admin_req_wfh/req_wfh_request_model.dart';

class AdminReqWfhDataSourceImpl extends AdminReqWfhDataSource {
  @override
  Future<AdminWfhResponse> getAllReqWfh(GetAdminWfhRequestModel request) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(request));
    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.employeeMobileApi,
    ).postDynamic('wfh_controller.php', encryptedBody);
    return AdminWfhResponse.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }

  @override
  Future<AdminWfhResponse> approveWfhRequest(
    AdminWfhApproveRequestModel request,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(request));
    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.employeeMobileApi,
    ).postDynamic('wfh_controller.php', encryptedBody);
    return AdminWfhResponse.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }

  @override
  Future<AdminWfhResponse> rejectWfhRequest(
    AdminWfhRejectRequestModel request,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(request));
    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.employeeMobileApi,
    ).postDynamic('wfh_controller.php', encryptedBody);
    return AdminWfhResponse.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }
}
