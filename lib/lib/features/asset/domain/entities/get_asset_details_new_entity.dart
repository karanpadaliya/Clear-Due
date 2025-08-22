class AssetDetailsEntity {
  final String? inventoryId;
  final String? assetsId;
  final String? assetsIdCode;
  final String? assetsCategory;
  final String? assetsBrandName;
  final String? assetsName;
  final String? userFullName;
  final String? blockName;
  final String? floorName;
  final String? userDesignation;
  final String? srNo;
  final String? userProfilePic;
  final String? shortName;
  final String? itemPurchaseDate;
  final String? itemPrice;
  final String? assetsFile;
  final String? handoverDate;
  final String? takeoverDate;
  final String? itemCreatedDate;
  final String? message;
  final String? status;
  final List<AssetsFileEntity>? assetsFiles;
  final List<HistoryEntity>? history;
  final List<AssetsFileEntity>? assetsFilesHandover;
  final List<AssetsFileEntity>? assetsFilesTakeover;

  AssetDetailsEntity({
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
}

class AssetsFileEntity {
  final String? name;
  final String? document;

  AssetsFileEntity({this.name, this.document});
}

class HistoryEntity {
  final String? inventoryId;
  final String? userFullName;
  final String? blockName;
  final String? floorName;
  final String? userDesignation;
  final String? shortName;
  final String? userProfilePic;
  final List<AssetsFileEntity>? assetsFilesHandover;
  final List<AssetsFileEntity>? assetsFilesTakeover;
  final String? handoverDate;
  final String? takeoverDate;

  HistoryEntity({
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
}
