import 'package:myco_flutter/core/models/data/common_response_model.dart';
import 'package:myco_flutter/features/lost_and_found/data/model/lost_and_found_response.dart';

abstract class LostAndFoundDataSource {
  Future<LostAndFoundResponseModel> getLostAndFoundItems(
    Map<String, String?> request,
  );

  Future<CommonResponseModel> addLostAndFoundItems(
    Map<String, String?> request,
  );

  Future<CommonResponseModel> editLostAndFoundItems(
    Map<String, String?> request,
  );

  Future<CommonResponseModel> deleteLostAndFoundItems(
    Map<String, String?> request,
  );
}
