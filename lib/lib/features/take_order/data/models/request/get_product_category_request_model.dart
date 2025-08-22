class GetProductCategoryRequestModel {
  String? getProductCategoryV2;
  String? societyId;
  String? applyGstOnOrder;
  String? companyStateId;
  String? stateId;
  String? userId;
  String? routeId;
  String? retailerId;
  String? applyFraightInTakeOrder;
  String? retailerProductView;

  GetProductCategoryRequestModel({
    this.getProductCategoryV2,
    this.societyId,
    this.applyGstOnOrder,
    this.companyStateId,
    this.stateId,
    this.userId,
    this.routeId,
    this.retailerId,
    this.applyFraightInTakeOrder,
    this.retailerProductView,
  });

  GetProductCategoryRequestModel.fromJson(Map<String, dynamic> json) {
    getProductCategoryV2 = json['getProductCategoryV2'];
    societyId = json['society_id'];
    applyGstOnOrder = json['apply_gst_on_order'];
    companyStateId = json['company_state_id'];
    stateId = json['state_id'];
    userId = json['user_id'];
    routeId = json['route_id'];
    retailerId = json['retailer_id'];
    applyFraightInTakeOrder = json['apply_fraight_in_take_order'];
    retailerProductView = json['retailer_product_view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getProductCategoryV2'] = this.getProductCategoryV2;
    data['society_id'] = this.societyId;
    data['apply_gst_on_order'] = this.applyGstOnOrder;
    data['company_state_id'] = this.companyStateId;
    data['state_id'] = this.stateId;
    data['user_id'] = this.userId;
    data['route_id'] = this.routeId;
    data['retailer_id'] = this.retailerId;
    data['apply_fraight_in_take_order'] = this.applyFraightInTakeOrder;
    data['retailer_product_view'] = this.retailerProductView;
    return data;
  }
}
