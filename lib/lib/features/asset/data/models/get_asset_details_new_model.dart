import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/asset/domain/entities/get_asset_details_new_entity.dart';

part 'get_asset_details_new_model.g.dart';

AssetDetailsModel assetDetailsModelFromJson(String str) =>
    AssetDetailsModel.fromJson(json.decode(str));

String assetDetailsModelToJson(AssetDetailsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AssetDetailsModel {
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'assets_id')
  final String? assetsId;
  @JsonKey(name: 'assets_id_code')
  final String? assetsIdCode;
  @JsonKey(name: 'assets_category')
  final String? assetsCategory;
  @JsonKey(name: 'assets_brand_name')
  final String? assetsBrandName;
  @JsonKey(name: 'assets_name')
  final String? assetsName;
  @JsonKey(name: 'user_full_name')
  final String? userFullName;
  @JsonKey(name: 'block_name')
  final String? blockName;
  @JsonKey(name: 'floor_name')
  final String? floorName;
  @JsonKey(name: 'user_designation')
  final String? userDesignation;
  @JsonKey(name: 'sr_no')
  final String? srNo;
  @JsonKey(name: 'user_profile_pic')
  final String? userProfilePic;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'item_purchase_date')
  final String? itemPurchaseDate;
  @JsonKey(name: 'item_price')
  final String? itemPrice;
  @JsonKey(name: 'assets_file')
  final String? assetsFile;
  @JsonKey(name: 'handover_date')
  final String? handoverDate;
  @JsonKey(name: 'takeover_date')
  final String? takeoverDate;
  @JsonKey(name: 'iteam_created_date')
  final String? itemCreatedDate;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'assets_files')
  final List<AssetsFileModel>? assetsFiles;
  @JsonKey(name: 'history')
  final List<HistoryModel>? history;
  @JsonKey(name: 'assets_files_handover')
  final List<AssetsFileModel>? assetsFilesHandover;
  @JsonKey(name: 'assets_files_takeover')
  final List<AssetsFileModel>? assetsFilesTakeover;

  AssetDetailsModel({
    this.inventoryId,
    this.assetsId,
    this.assetsIdCode,
    this.assetsCategory,
    this.assetsBrandName,
    this.assetsName,
    this.userFullName,
    this.blockName,
    this.floorName,
    this.userDesignation,
    this.srNo,
    this.userProfilePic,
    this.shortName,
    this.itemPurchaseDate,
    this.itemPrice,
    this.assetsFile,
    this.handoverDate,
    this.takeoverDate,
    this.itemCreatedDate,
    this.message,
    this.status,
    this.assetsFiles,
    this.history,
    this.assetsFilesHandover,
    this.assetsFilesTakeover,
  });

  factory AssetDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AssetDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetDetailsModelToJson(this);
}

@JsonSerializable()
class AssetsFileModel {
  final String? name;
  final String? document;

  AssetsFileModel({this.name, this.document});

  factory AssetsFileModel.fromJson(Map<String, dynamic> json) =>
      _$AssetsFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetsFileModelToJson(this);
}

@JsonSerializable()
class HistoryModel {
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'user_full_name')
  final String? userFullName;
  @JsonKey(name: 'block_name')
  final String? blockName;
  @JsonKey(name: 'floor_name')
  final String? floorName;
  @JsonKey(name: 'user_designation')
  final String? userDesignation;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'user_profile_pic')
  final String? userProfilePic;
  @JsonKey(name: 'assets_files_handover')
  final List<AssetsFileModel>? assetsFilesHandover;
  @JsonKey(name: 'assets_files_takeover')
  final List<AssetsFileModel>? assetsFilesTakeover;
  @JsonKey(name: 'handover_date')
  final String? handoverDate;
  @JsonKey(name: 'takeover_date')
  final String? takeoverDate;

  HistoryModel({
    this.inventoryId,
    this.userFullName,
    this.blockName,
    this.floorName,
    this.userDesignation,
    this.shortName,
    this.userProfilePic,
    this.assetsFilesHandover,
    this.assetsFilesTakeover,
    this.handoverDate,
    this.takeoverDate,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}

extension AssetDetailsModelMapper on AssetDetailsModel {
  AssetDetailsEntity toEntity() => AssetDetailsEntity(
        inventoryId: inventoryId,
        assetsId: assetsId,
        assetsIdCode: assetsIdCode,
        assetsCategory: assetsCategory,
        assetsBrandName: assetsBrandName,
        assetsName: assetsName,
        userFullName: userFullName,
        blockName: blockName,
        floorName: floorName,
        userDesignation: userDesignation,
        srNo: srNo,
        userProfilePic: userProfilePic,
        shortName: shortName,
        itemPurchaseDate: itemPurchaseDate,
        itemPrice: itemPrice,
        assetsFile: assetsFile,
        handoverDate: handoverDate,
        takeoverDate: takeoverDate,
        itemCreatedDate: itemCreatedDate,
        message: message,
        status: status,
        assetsFiles: assetsFiles?.map((e) => e.toEntity()).toList(),
        history: history?.map((h) => h.toEntity()).toList(),
        assetsFilesHandover:
            assetsFilesHandover?.map((e) => e.toEntity()).toList(),
        assetsFilesTakeover:
            assetsFilesTakeover?.map((e) => e.toEntity()).toList(),
      );
}

extension AssetsFileModelMapper on AssetsFileModel {
  AssetsFileEntity toEntity() => AssetsFileEntity(
        name: name,
        document: document,
      );
}

extension HistoryModelMapper on HistoryModel {
  HistoryEntity toEntity() => HistoryEntity(
        inventoryId: inventoryId,
        userFullName: userFullName,
        blockName: blockName,
        floorName: floorName,
        userDesignation: userDesignation,
        shortName: shortName,
        userProfilePic: userProfilePic,
        assetsFilesHandover:
            assetsFilesHandover?.map((e) => e.toEntity()).toList(),
        assetsFilesTakeover:
            assetsFilesTakeover?.map((e) => e.toEntity()).toList(),
        handoverDate: handoverDate,
        takeoverDate: takeoverDate,
      );
}
