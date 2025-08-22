// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_asset_details_new_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetDetailsModel _$AssetDetailsModelFromJson(Map<String, dynamic> json) =>
    AssetDetailsModel(
      inventoryId: json['inventory_id'] as String?,
      assetsId: json['assets_id'] as String?,
      assetsIdCode: json['assets_id_code'] as String?,
      assetsCategory: json['assets_category'] as String?,
      assetsBrandName: json['assets_brand_name'] as String?,
      assetsName: json['assets_name'] as String?,
      userFullName: json['user_full_name'] as String?,
      blockName: json['block_name'] as String?,
      floorName: json['floor_name'] as String?,
      userDesignation: json['user_designation'] as String?,
      srNo: json['sr_no'] as String?,
      userProfilePic: json['user_profile_pic'] as String?,
      shortName: json['short_name'] as String?,
      itemPurchaseDate: json['item_purchase_date'] as String?,
      itemPrice: json['item_price'] as String?,
      assetsFile: json['assets_file'] as String?,
      handoverDate: json['handover_date'] as String?,
      takeoverDate: json['takeover_date'] as String?,
      itemCreatedDate: json['iteam_created_date'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      assetsFiles:
          (json['assets_files'] as List<dynamic>?)
              ?.map((e) => AssetsFileModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      history:
          (json['history'] as List<dynamic>?)
              ?.map((e) => HistoryModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      assetsFilesHandover:
          (json['assets_files_handover'] as List<dynamic>?)
              ?.map((e) => AssetsFileModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      assetsFilesTakeover:
          (json['assets_files_takeover'] as List<dynamic>?)
              ?.map((e) => AssetsFileModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$AssetDetailsModelToJson(AssetDetailsModel instance) =>
    <String, dynamic>{
      'inventory_id': instance.inventoryId,
      'assets_id': instance.assetsId,
      'assets_id_code': instance.assetsIdCode,
      'assets_category': instance.assetsCategory,
      'assets_brand_name': instance.assetsBrandName,
      'assets_name': instance.assetsName,
      'user_full_name': instance.userFullName,
      'block_name': instance.blockName,
      'floor_name': instance.floorName,
      'user_designation': instance.userDesignation,
      'sr_no': instance.srNo,
      'user_profile_pic': instance.userProfilePic,
      'short_name': instance.shortName,
      'item_purchase_date': instance.itemPurchaseDate,
      'item_price': instance.itemPrice,
      'assets_file': instance.assetsFile,
      'handover_date': instance.handoverDate,
      'takeover_date': instance.takeoverDate,
      'iteam_created_date': instance.itemCreatedDate,
      'message': instance.message,
      'status': instance.status,
      'assets_files': instance.assetsFiles,
      'history': instance.history,
      'assets_files_handover': instance.assetsFilesHandover,
      'assets_files_takeover': instance.assetsFilesTakeover,
    };

AssetsFileModel _$AssetsFileModelFromJson(Map<String, dynamic> json) =>
    AssetsFileModel(
      name: json['name'] as String?,
      document: json['document'] as String?,
    );

Map<String, dynamic> _$AssetsFileModelToJson(AssetsFileModel instance) =>
    <String, dynamic>{'name': instance.name, 'document': instance.document};

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
  inventoryId: json['inventory_id'] as String?,
  userFullName: json['user_full_name'] as String?,
  blockName: json['block_name'] as String?,
  floorName: json['floor_name'] as String?,
  userDesignation: json['user_designation'] as String?,
  shortName: json['short_name'] as String?,
  userProfilePic: json['user_profile_pic'] as String?,
  assetsFilesHandover:
      (json['assets_files_handover'] as List<dynamic>?)
          ?.map((e) => AssetsFileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  assetsFilesTakeover:
      (json['assets_files_takeover'] as List<dynamic>?)
          ?.map((e) => AssetsFileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  handoverDate: json['handover_date'] as String?,
  takeoverDate: json['takeover_date'] as String?,
);

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'inventory_id': instance.inventoryId,
      'user_full_name': instance.userFullName,
      'block_name': instance.blockName,
      'floor_name': instance.floorName,
      'user_designation': instance.userDesignation,
      'short_name': instance.shortName,
      'user_profile_pic': instance.userProfilePic,
      'assets_files_handover': instance.assetsFilesHandover,
      'assets_files_takeover': instance.assetsFilesTakeover,
      'handover_date': instance.handoverDate,
      'takeover_date': instance.takeoverDate,
    };
