import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/asset/domain/entities/asset_information_entity.dart';

part 'asset_information_model.g.dart';

// JSON parsing helpers
AssetInformationModel assetInformationModelFromJson(String str) =>
    AssetInformationModel.fromJson(json.decode(str));

String assetInformationModelToJson(AssetInformationModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AssetInformationModel {
  @JsonKey(name: 'assets_id')
  final String? assetsId;
  @JsonKey(name: 'assets_id_view')
  final String? assetsIdView;
  @JsonKey(name: 'assets_category_id')
  final String? assetsCategoryId;
  @JsonKey(name: 'assets_category')
  final String? assetsCategory;
  @JsonKey(name: 'assets_brand_name')
  final String? assetsBrandName;
  @JsonKey(name: 'assets_name')
  final String? assetsName;
  @JsonKey(name: 'assets_location')
  final String? assetsLocation;
  @JsonKey(name: 'assets_item_code')
  final String? assetsItemCode;
  @JsonKey(name: 'assets_description')
  final String? assetsDescription;
  @JsonKey(name: 'assets_invoice')
  final String? assetsInvoice;
  @JsonKey(name: 'assets_invoice_name')
  final String? assetsInvoiceName;
  @JsonKey(name: 'sr_no')
  final String? srNo;
  @JsonKey(name: 'custodian')
  final String? custodian;
  @JsonKey(name: 'item_purchase_date')
  final String? itemPurchaseDate;
  @JsonKey(name: 'qr_code')
  final String? qrCode;
  @JsonKey(name: 'item_price')
  final String? itemPrice;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'asset_credential')
  final String? assetCredential;
  @JsonKey(name: 'assets_file')
  final String? assetsFile;
  @JsonKey(name: 'assets_files')
  final List<AssetFileModel>? assetsFiles;
  @JsonKey(name: 'iteam_created_date')
  final String? iteamCreatedDate;
  @JsonKey(name: 'history')
  final List<AssetHistoryModel>? history;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'assets_file_pass')
  final String? assetsFilePass;
  @JsonKey(name: 'created_by_name')
  final String? createdByName;

  const AssetInformationModel({
    this.assetsId,
    this.assetsIdView,
    this.assetsCategoryId,
    this.assetsCategory,
    this.assetsBrandName,
    this.assetsName,
    this.assetsLocation,
    this.assetsItemCode,
    this.assetsDescription,
    this.assetsInvoice,
    this.assetsInvoiceName,
    this.srNo,
    this.custodian,
    this.itemPurchaseDate,
    this.qrCode,
    this.itemPrice,
    this.status,
    this.assetCredential,
    this.assetsFile,
    this.assetsFiles,
    this.iteamCreatedDate,
    this.history,
    this.message,
    this.assetsFilePass,
    this.createdByName,
  });

  factory AssetInformationModel.fromJson(Map<String, dynamic> json) =>
      _$AssetInformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetInformationModelToJson(this);
}

@JsonSerializable()
class AssetFileModel {
  final String? name;
  final String? document;

  const AssetFileModel({this.name, this.document});

  factory AssetFileModel.fromJson(Map<String, dynamic> json) =>
      _$AssetFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetFileModelToJson(this);
}

@JsonSerializable()
class AssetHistoryModel {
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'user_full_name')
  final String? userFullName;
  @JsonKey(name: 'block_name')
  final String? blockName;
  @JsonKey(name: 'floor_name')
  final String? floorName;
  @JsonKey(name: 'floor_id')
  final String? floorId;
  @JsonKey(name: 'user_designation')
  final String? userDesignation;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'user_profile_pic')
  final String? userProfilePic;
  @JsonKey(name: 'assets_files_handover')
  final List<AssetFileModel>? assetsFilesHandover;
  @JsonKey(name: 'assets_files_takeover')
  final List<AssetFileModel>? assetsFilesTakeover;
  @JsonKey(name: 'handover_date')
  final String? handoverDate;
  @JsonKey(name: 'takeover_date')
  final String? takeoverDate;
  @JsonKey(name: 'handover_by_name')
  final String? handoverByName;
  @JsonKey(name: 'takeover_by_name')
  final String? takeoverByName;

  const AssetHistoryModel({
    this.inventoryId,
    this.userFullName,
    this.blockName,
    this.floorName,
    this.floorId,
    this.userDesignation,
    this.shortName,
    this.userId,
    this.userProfilePic,
    this.assetsFilesHandover,
    this.assetsFilesTakeover,
    this.handoverDate,
    this.takeoverDate,
    this.handoverByName,
    this.takeoverByName,
  });

  factory AssetHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$AssetHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetHistoryModelToJson(this);
}

// ==== MODEL to ENTITY MAPPERS ====
// You may use extension methods or instance methods as per your project preference

extension AssetInformationModelMapper on AssetInformationModel {
  AssetInformationEntity toEntity() => AssetInformationEntity(
        assetsId: assetsId,
        assetsIdView: assetsIdView,
        assetsCategoryId: assetsCategoryId,
        assetsCategory: assetsCategory,
        assetsBrandName: assetsBrandName,
        assetsName: assetsName,
        assetsLocation: assetsLocation,
        assetsItemCode: assetsItemCode,
        assetsDescription: assetsDescription,
        assetsInvoice: assetsInvoice,
        assetsInvoiceName: assetsInvoiceName,
        srNo: srNo,
        custodian: custodian,
        itemPurchaseDate: itemPurchaseDate,
        qrCode: qrCode,
        itemPrice: itemPrice,
        status: status,
        assetCredential: assetCredential,
        assetsFile: assetsFile,
        assetsFiles: assetsFiles?.map((e) => e.toEntity()).toList(),
        iteamCreatedDate: iteamCreatedDate,
        history: history?.map((h) => h.toEntity()).toList(),
        message: message,
        assetsFilePass: assetsFilePass,
        createdByName: createdByName,
      );
}

extension AssetFileModelMapper on AssetFileModel {
  AssetFileEntity toEntity() => AssetFileEntity(
        name: name,
        document: document,
      );
}

extension AssetHistoryModelMapper on AssetHistoryModel {
  AssetHistoryEntity toEntity() => AssetHistoryEntity(
        inventoryId: inventoryId,
        userFullName: userFullName,
        blockName: blockName,
        floorName: floorName,
        floorId: floorId,
        userDesignation: userDesignation,
        shortName: shortName,
        userId: userId,
        userProfilePic: userProfilePic,
        assetsFilesHandover: assetsFilesHandover?.map((e) => e.toEntity()).toList(),
        assetsFilesTakeover: assetsFilesTakeover?.map((e) => e.toEntity()).toList(),
        handoverDate: handoverDate,
        takeoverDate: takeoverDate,
        handoverByName: handoverByName,
        takeoverByName: takeoverByName,
      );
}
