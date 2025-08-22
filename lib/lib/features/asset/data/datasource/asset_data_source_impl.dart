import 'dart:convert';
import 'dart:developer';
import 'package:myco_flutter/core/encryption/gzip_util.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/asset/data/datasource/asset_data_source.dart';
import 'package:myco_flutter/features/asset/data/models/add_asset_model.dart';
import 'package:myco_flutter/features/asset/data/models/add_asset_user_model.dart';
import 'package:myco_flutter/features/asset/data/models/all_assets_model.dart';
import 'package:myco_flutter/features/asset/data/models/asset_information_model.dart';
import 'package:myco_flutter/features/asset/data/models/asset_model.dart';
import 'package:myco_flutter/features/asset/data/models/get_asset_details_new_model.dart';

class AssetsRemoteDataSourceImpl extends AssetsRemoteDataSource {
  final ApiClient apiClient;

  AssetsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AssetModel> getAssets(Map<String, dynamic> dataMap) async {
    final encryptedBody = GzipUtil.encryptAES(json.encode(dataMap));

    final response = await apiClient.postDynamic(
      'assets_controller.php',
      encryptedBody,
    );

    final decrypt = GzipUtil.decryptAES(response);
    log(decrypt.toString());
    return AssetModel.fromJson(json.decode(decrypt));
  }
}

class AllAssetsRemoteDataSourceImpl extends AllAssetsRemoteDataSource {
  final ApiClient apiClient;

  AllAssetsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AllAssetsModel> getAllAssets(Map<String, dynamic> dataMap) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(dataMap));
    final response = await apiClient.postDynamic(
      'assets_controller.php',
      encryptedBody,
    );

    return AllAssetsModel.fromJson(json.decode(GzipUtil.decryptAES(response)));
  }
}

class AddAssetDataSourceImpl extends AddAssetDataSource {
  final ApiClient apiClient;

  AddAssetDataSourceImpl({required this.apiClient});

  @override
  Future<AddAssetModel> getAddAsset(Map<String, dynamic> dataMap) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(dataMap));
    final response = await apiClient.postDynamic(
      'assets_controller.php',
      encryptedBody,
    );

    return AddAssetModel.fromJson(json.decode(GzipUtil.decryptAES(response)));
  }
}

class AddAssetUserDataSourceImpl extends AddAssetUserDataSource {
  final ApiClient apiClient;

  AddAssetUserDataSourceImpl({required this.apiClient});

  @override
  Future<AddAssetUserModel> getAddAssetUser(
    Map<String, dynamic> dataMap,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(dataMap));
    final response = await apiClient.postDynamic(
      'view_member_list_controller.php',
      encryptedBody,
    );

    return AddAssetUserModel.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }
}

class GetAssetDetailsDataSourceImpl extends GetAssetDetailsDataSource {
  final ApiClient apiClient;

  GetAssetDetailsDataSourceImpl({required this.apiClient});

  @override
  Future<AssetDetailsModel> getAssetDetails(
    Map<String, dynamic> dataMap,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(dataMap));
    final response = await apiClient.postDynamic(
      'assets_controller.php',
      encryptedBody,
    );

    return AssetDetailsModel.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }
}

class GetAssetInformationDataSourceImpl extends GetAssetInformationDataSource {
  final ApiClient apiClient;

  GetAssetInformationDataSourceImpl({required this.apiClient});

  @override
  Future<AssetInformationModel> getAssetInformation(
    Map<String, dynamic> dataMap,
  ) async {
    final encryptedBody = GzipUtil.encryptAES(jsonEncode(dataMap));
    final response = await apiClient.postDynamic(
      'assets_controller.php',
      encryptedBody,
    );

    return AssetInformationModel.fromJson(
      json.decode(GzipUtil.decryptAES(response)),
    );
  }
}
