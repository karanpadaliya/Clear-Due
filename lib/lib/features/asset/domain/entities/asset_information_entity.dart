class AssetInformationEntity {
  final String? assetsId;
  final String? assetsIdView;
  final String? assetsCategoryId;
  final String? assetsCategory;
  final String? assetsBrandName;
  final String? assetsName;
  final String? assetsLocation;
  final String? assetsItemCode;
  final String? assetsDescription;
  final String? assetsInvoice;
  final String? assetsInvoiceName;
  final String? srNo;
  final String? custodian;
  final String? itemPurchaseDate;
  final String? qrCode;
  final String? itemPrice;
  final String? status;
  final String? assetCredential;
  final String? assetsFile;
  final List<AssetFileEntity>? assetsFiles;
  final String? iteamCreatedDate;
  final List<AssetHistoryEntity>? history;
  final String? message;
  final String? assetsFilePass;
  final String? createdByName;

  AssetInformationEntity({
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
}

class AssetFileEntity {
  final String? name;
  final String? document;

  AssetFileEntity({this.name, this.document});
}

class AssetHistoryEntity {
  final String? inventoryId;
  final String? userFullName;
  final String? blockName;
  final String? floorName;
  final String? floorId;
  final String? userDesignation;
  final String? shortName;
  final String? userId;
  final String? userProfilePic;
  final List<AssetFileEntity>? assetsFilesHandover;
  final List<AssetFileEntity>? assetsFilesTakeover;
  final String? handoverDate;
  final String? takeoverDate;
  final String? handoverByName;
  final String? takeoverByName;

  AssetHistoryEntity({
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
}
