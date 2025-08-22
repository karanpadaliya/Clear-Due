// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetInformationModel _$AssetInformationModelFromJson(
  Map<String, dynamic> json,
) => AssetInformationModel(
  assetsId: json['assets_id'] as String?,
  assetsIdView: json['assets_id_view'] as String?,
  assetsCategoryId: json['assets_category_id'] as String?,
  assetsCategory: json['assets_category'] as String?,
  assetsBrandName: json['assets_brand_name'] as String?,
  assetsName: json['assets_name'] as String?,
  assetsLocation: json['assets_location'] as String?,
  assetsItemCode: json['assets_item_code'] as String?,
  assetsDescription: json['assets_description'] as String?,
  assetsInvoice: json['assets_invoice'] as String?,
  assetsInvoiceName: json['assets_invoice_name'] as String?,
  srNo: json['sr_no'] as String?,
  custodian: json['custodian'] as String?,
  itemPurchaseDate: json['item_purchase_date'] as String?,
  qrCode: json['qr_code'] as String?,
  itemPrice: json['item_price'] as String?,
  status: json['status'] as String?,
  assetCredential: json['asset_credential'] as String?,
  assetsFile: json['assets_file'] as String?,
  assetsFiles:
      (json['assets_files'] as List<dynamic>?)
          ?.map((e) => AssetFileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  iteamCreatedDate: json['iteam_created_date'] as String?,
  history:
      (json['history'] as List<dynamic>?)
          ?.map((e) => AssetHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
  assetsFilePass: json['assets_file_pass'] as String?,
  createdByName: json['created_by_name'] as String?,
);

Map<String, dynamic> _$AssetInformationModelToJson(
  AssetInformationModel instance,
) => <String, dynamic>{
  'assets_id': instance.assetsId,
  'assets_id_view': instance.assetsIdView,
  'assets_category_id': instance.assetsCategoryId,
  'assets_category': instance.assetsCategory,
  'assets_brand_name': instance.assetsBrandName,
  'assets_name': instance.assetsName,
  'assets_location': instance.assetsLocation,
  'assets_item_code': instance.assetsItemCode,
  'assets_description': instance.assetsDescription,
  'assets_invoice': instance.assetsInvoice,
  'assets_invoice_name': instance.assetsInvoiceName,
  'sr_no': instance.srNo,
  'custodian': instance.custodian,
  'item_purchase_date': instance.itemPurchaseDate,
  'qr_code': instance.qrCode,
  'item_price': instance.itemPrice,
  'status': instance.status,
  'asset_credential': instance.assetCredential,
  'assets_file': instance.assetsFile,
  'assets_files': instance.assetsFiles,
  'iteam_created_date': instance.iteamCreatedDate,
  'history': instance.history,
  'message': instance.message,
  'assets_file_pass': instance.assetsFilePass,
  'created_by_name': instance.createdByName,
};

AssetFileModel _$AssetFileModelFromJson(Map<String, dynamic> json) =>
    AssetFileModel(
      name: json['name'] as String?,
      document: json['document'] as String?,
    );

Map<String, dynamic> _$AssetFileModelToJson(AssetFileModel instance) =>
    <String, dynamic>{'name': instance.name, 'document': instance.document};

AssetHistoryModel _$AssetHistoryModelFromJson(Map<String, dynamic> json) =>
    AssetHistoryModel(
      inventoryId: json['inventory_id'] as String?,
      userFullName: json['user_full_name'] as String?,
      blockName: json['block_name'] as String?,
      floorName: json['floor_name'] as String?,
      floorId: json['floor_id'] as String?,
      userDesignation: json['user_designation'] as String?,
      shortName: json['short_name'] as String?,
      userId: json['user_id'] as String?,
      userProfilePic: json['user_profile_pic'] as String?,
      assetsFilesHandover:
          (json['assets_files_handover'] as List<dynamic>?)
              ?.map((e) => AssetFileModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      assetsFilesTakeover:
          (json['assets_files_takeover'] as List<dynamic>?)
              ?.map((e) => AssetFileModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      handoverDate: json['handover_date'] as String?,
      takeoverDate: json['takeover_date'] as String?,
      handoverByName: json['handover_by_name'] as String?,
      takeoverByName: json['takeover_by_name'] as String?,
    );

Map<String, dynamic> _$AssetHistoryModelToJson(AssetHistoryModel instance) =>
    <String, dynamic>{
      'inventory_id': instance.inventoryId,
      'user_full_name': instance.userFullName,
      'block_name': instance.blockName,
      'floor_name': instance.floorName,
      'floor_id': instance.floorId,
      'user_designation': instance.userDesignation,
      'short_name': instance.shortName,
      'user_id': instance.userId,
      'user_profile_pic': instance.userProfilePic,
      'assets_files_handover': instance.assetsFilesHandover,
      'assets_files_takeover': instance.assetsFilesTakeover,
      'handover_date': instance.handoverDate,
      'takeover_date': instance.takeoverDate,
      'handover_by_name': instance.handoverByName,
      'takeover_by_name': instance.takeoverByName,
    };
