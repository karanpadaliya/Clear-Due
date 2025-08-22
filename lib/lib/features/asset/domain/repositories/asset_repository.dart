import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/asset/domain/entities/add_asset_entity.dart';
import 'package:myco_flutter/features/asset/domain/entities/add_asset_user_entity.dart';
import 'package:myco_flutter/features/asset/domain/entities/all_assets_entity.dart';
import 'package:myco_flutter/features/asset/domain/entities/asset_entity.dart';
import 'package:myco_flutter/features/asset/domain/entities/asset_information_entity.dart';
import 'package:myco_flutter/features/asset/domain/entities/get_asset_details_new_entity.dart';

abstract class AssetsRepository {
  /// Retrieves asset data.
  ///
  /// Returns [Either<Failure, AssetsEntity>] on success/failure.
  Future<Either<Failure, AssetsEntity>> getAssets(Map<String, dynamic> dataMap);
}

abstract class AllAssetsRepository {
  /// Retrieves all assets data including categories, brands, and assets list.
  ///
  /// Returns [Either<Failure, AllAssetsEntity>] on success/failure.
  Future<Either<Failure, AllAssetsEntity>> getAllAssets(
    Map<String, dynamic> dataMap,
  );
}

abstract class AddAssetRepository {
  /// Retrieves all assets data including categories, brands, and assets list.
  ///
  /// Returns [Either<Failure, AddAssetEntity>] on success/failure.
  Future<Either<Failure, AddAssetEntity>> getAddAsset(
    Map<String, dynamic> dataMap,
  );
}

abstract class AddAssetUserRepository {
  /// Retrieves all assets data including categories, brands, and assets list.
  ///
  /// Returns [Either<Failure, AddAssetUserEntity>] on success/failure.
  Future<Either<Failure, AddAssetUserEntity>> getAddAssetUser(
    Map<String, dynamic> dataMap,
  );
}

abstract class GetAssetDetailsRepository {
  /// Retrieves all assets data including categories, brands, and assets list.
  ///
  /// Returns [Either<Failure, AssetDetailsEntity>] on success/failure.
  Future<Either<Failure, AssetDetailsEntity>> getAssetDetails(
    Map<String, dynamic> dataMap,
  );
}

abstract class GetAssetInformationRepository {
  /// Retrieves all assets data including categories, brands, and assets list.
  ///
  /// Returns [Either<Failure, AssetInformationEntity>] on success/failure.
  Future<Either<Failure, AssetInformationEntity>> getAssetInformation(
    Map<String, dynamic> dataMap,
  );
}
