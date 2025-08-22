import 'package:myco_flutter/features/take_order/data/models/response/get_frequent_products_model.dart';
import 'package:myco_flutter/features/take_order/data/models/response/get_product_category_model.dart';
import 'package:myco_flutter/features/take_order/data/models/response/retailer_details_model.dart';

abstract class TakeOrderRemoteDatasource {
  Future<RetailerDetailsModel> getRetailerDetails();
  Future<GetProductCategoryModel> getProductCategory();
  Future<GetFrequentProductsModel> getFrequentProducts();
}
