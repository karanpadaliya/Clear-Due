import 'package:myco_flutter/features/asset/data/models/add_asset_model.dart';
import 'package:myco_flutter/features/asset/data/models/add_asset_user_model.dart';
import 'package:myco_flutter/features/asset/data/models/all_assets_model.dart';
import 'package:myco_flutter/features/asset/data/models/asset_information_model.dart';
import 'package:myco_flutter/features/asset/data/models/asset_model.dart';
import 'package:myco_flutter/features/asset/data/models/get_asset_details_new_model.dart';

abstract class AssetsRemoteDataSource {
  /// Fetches the asset list from the remote server.
  ///
  /// Returns an [AssetModel] containing asset data.
  Future<AssetModel> getAssets(Map<String, dynamic> dataMap);
}

abstract class AllAssetsRemoteDataSource {
  /// Fetches the all assets list from the remote server.
  ///
  /// Returns an [AllAssetsModel] containing all assets data including categories, brands, and assets.
  Future<AllAssetsModel> getAllAssets(Map<String, dynamic> dataMap);
}

abstract class AddAssetDataSource {
  /// Fetches the all assets list from the remote server.
  ///
  /// Returns an [AddAssetModel] containing all assets data including categories, brands, and assets.
  Future<AddAssetModel> getAddAsset(Map<String, dynamic> dataMap);
}

abstract class AddAssetUserDataSource {
  /// Fetches the all assets list from the remote server.
  ///
  /// Returns an [AddAssetUserModel] containing all assets data including categories, brands, and assets.
  Future<AddAssetUserModel> getAddAssetUser(Map<String, dynamic> dataMap);
}

abstract class GetAssetDetailsDataSource {
  /// Fetches the all assets list from the remote server.
  ///
  /// Returns an [AssetDetailsModel] containing all assets data including categories, brands, and assets.
  Future<AssetDetailsModel> getAssetDetails(Map<String, dynamic> dataMap);
}

abstract class GetAssetInformationDataSource {
  /// Fetches the all assets list from the remote server.
  ///
  /// Returns an [AssetInformationModel] containing all assets data including categories, brands, and assets.
  Future<AssetInformationModel> getAssetInformation(
    Map<String, dynamic> dataMap,
  );
}
