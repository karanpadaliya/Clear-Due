import 'dart:convert';
import 'package:myco_flutter/core/encryption/gzip_util.dart';
import 'package:myco_flutter/core/models/data/common_response_model.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/lost_and_found/data/data_sources/lost_and_found_data_source.dart';
import 'package:myco_flutter/features/lost_and_found/data/model/lost_and_found_response.dart';

class LostAndFoundDataSourceImpl implements LostAndFoundDataSource {
  final ApiClient apiClient;

  LostAndFoundDataSourceImpl({required this.apiClient});

  final controller = 'lost_found_controller.php';

  @override
  Future<LostAndFoundResponseModel> getLostAndFoundItems(
    Map<String, String?> request,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(request));

    final response = await apiClient.postDynamic(controller, encryptedBody);
    return LostAndFoundResponseModel.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }

  @override
  Future<CommonResponseModel> addLostAndFoundItems(
    Map<String, String?> request,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(request));

    final response = await apiClient.postDynamic(controller, encryptedBody);
    return CommonResponseModel.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }

  @override
  Future<CommonResponseModel> editLostAndFoundItems(
    Map<String, String?> request,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(request));

    final response = await apiClient.postDynamic(controller, encryptedBody);
    return CommonResponseModel.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }

  @override
  Future<CommonResponseModel> deleteLostAndFoundItems(
    Map<String, String?> request,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(request));

    final response = await apiClient.postDynamic(controller, encryptedBody);
    return CommonResponseModel.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }
}
