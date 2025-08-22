import 'dart:convert';
import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/encryption/gzip_util.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/work_from_home/data/data_source/add_wfh/my_wfh_data_source.dart';
import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_model.dart';
import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_request_model.dart';

class AddWfhDataSourceImpl extends AddWfhRemoteDataSource {
  final ApiClient apiClient;

  AddWfhDataSourceImpl({required this.apiClient});

  @override
  Future<AddWfhResponse> getAddWfh(GetMyWfhRequestModel request) async {
    final encryptedBody = GzipUtil.encryptAES(json.encode(request.toJson()));

    // final response = await apiClient.postDynamic(
    //   'wfh_controller.php',
    //   encryptedBody,
    // );
    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.employeeMobileApi,
    ).postDynamic('wfh_controller.php', encryptedBody);
    final decrypt = GzipUtil.decryptAES(response);
    log(decrypt.toString());
    return AddWfhResponse.fromJson(json.decode(decrypt));
  }

  @override
  Future<AddWfhResponse> deleteWfhRequest(DeleteWfhRequestModel request) async {
    final encryptedBody = GzipUtil.encryptAES(json.encode(request.toJson()));

    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.employeeMobileApi,
    ).postDynamic('wfh_controller.php', encryptedBody);

    final decrypt = GzipUtil.decryptAES(response);
    log(decrypt.toString());
    return AddWfhResponse.fromJson(json.decode(decrypt));
  }

  @override
  Future<AddWfhResponse> addWfhRequest(AddWfhRequestModel request) async {
    final encryptedBody = GzipUtil.encryptAES(json.encode(request.toJson()));

    final response = await GetIt.I<ApiClient>(
      instanceName: VariableBag.employeeMobileApi,
    ).postDynamic('wfh_controller.php', encryptedBody);

    final decrypt = GzipUtil.decryptAES(response);
    log(decrypt.toString());
    return AddWfhResponse.fromJson(json.decode(decrypt));
  }
}
