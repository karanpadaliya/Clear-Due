import 'dart:convert';
import 'dart:developer';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/take_order/data/datasources/take_order_remote_datasource.dart';
import 'package:myco_flutter/features/take_order/data/models/request/get_product_category_request_model.dart';
import 'package:myco_flutter/features/take_order/data/models/request/retailer_details_request_model.dart';
import 'package:myco_flutter/features/take_order/data/models/response/get_frequent_products_model.dart';
import 'package:myco_flutter/features/take_order/data/models/response/get_product_category_model.dart';
import 'package:myco_flutter/features/take_order/data/models/response/retailer_details_model.dart';

class TakeOrderRemoteDatasourceImpl extends TakeOrderRemoteDatasource {
  final ApiClient apiClient;

  TakeOrderRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<RetailerDetailsModel> getRetailerDetails() async {
    final body = RetailerDetailsRequestModel(
      getRetailerDetailsNew: 'getRetailerDetailsNew',
      userId: '1259',
      retailerId: '1043',
      isByPass: '1',
      societyId: '1',
      startVisitId: '0',
      thirdPartyContactNumber: '',
      retailerExternalData: '',
    ).toJson();

    final response = await apiClient.postFormDynamic(
      'retailer_controller.php',
      body,
    );
    log(
      response.toString(),
      name: 'THIS IS RESPONSE FROM TAKE ORDER REMOTE DATA SOURCE',
    );
    return RetailerDetailsModel.fromJson(json.decode(response));
  }

  @override
  Future<GetProductCategoryModel> getProductCategory() async {
    final body = GetProductCategoryRequestModel(
      getProductCategoryV2: 'getProductCategoryV2',
      societyId: '1',
      applyGstOnOrder: '1',
      companyStateId: '1558',
      stateId: '1568',
      userId: '1259',
      routeId: '',
      retailerId: '279',
      applyFraightInTakeOrder: '1',
      retailerProductView: '1',
    ).toJson();

    final response = await apiClient.postFormDynamic(
      'retailer_product_controller.php',
      body,
    );

    log(
      response.toString(),
      name:
          'THIS IS RESPONSE FROM TAKE ORDER REMOTE DATA SOURCE GET PRODUCT CATEGORY',
    );

    return GetProductCategoryModel.fromJson(json.decode(response));
  }

  Future<GetFrequentProductsModel> getFrequentProducts() async {
    final body = {
      'getFrequentProducts': 'getFrequentProducts',
      'society_id': '1',
      'user_id': '1259',
      'retailer_id': '1',
    };

    final response = await apiClient.postFormDynamic(
      'retailer_product_controller.php',
      body,
    );

    return GetFrequentProductsModel.fromJson(json.decode(response));
  }
}
