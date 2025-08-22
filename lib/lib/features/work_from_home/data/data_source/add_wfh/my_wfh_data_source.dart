import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_model.dart';
import 'package:myco_flutter/features/work_from_home/data/models/add_wfh/add_wfh_request_model.dart';

abstract class AddWfhRemoteDataSource {
  /// Fetches the asset list from the remote server.
  ///
  /// Returns an [AddWfhResponse] containing asset data.
  Future<AddWfhResponse> getAddWfh(GetMyWfhRequestModel request);
  Future<AddWfhResponse> deleteWfhRequest(DeleteWfhRequestModel request);
  Future<AddWfhResponse> addWfhRequest(AddWfhRequestModel request);
}
