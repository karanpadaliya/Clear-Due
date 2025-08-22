import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';

enum AddAssetFieldKey {
  category,
  itemName,
  brandName,
  location,
  itemCode,
  description,
  purchaseDate,
  sno,
  price,
  assetCredential,
  branch,
  department,
  custodian,
}

class AssetUtils{

void fetchImageDataApi(BuildContext context, List<String> imgList) {
  context.read<CommonApiBloc>().add(UploadAttachments(true, imgList));
}

}
