import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/api.dart';
import '../model/helper/product_list_params.dart';
import '../model/helper/variant_list_params.dart';

abstract class ProductRepo {
  const ProductRepo();

  /// method to get product list
  /// header : Content-Type application/json
  static Future<SuperResponseModel> productList({
    ProductListParams params,
  }) async {
    var url = ProductAPIs.productList;

    if (params != null) {
      url += params.parse;
    }

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }

  // method to get product list
  // PARAMS : limit=20&offset=0
  // params => productList?limit=20&offset=0
  // header : Content-Type application/json
  static Future<SuperResponseModel> productById(int id) async {
    assert(id != null);

    final url = '${ProductAPIs.getProduct}?product_id=$id';

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }

  //-- Variant --//
  // method to get variant by product id and attributes id
  // PARAMS : getVariantByAttrUrl?product_id=5
  // header : Content-Type application/json
  static Future<SuperResponseModel> getVariantByAttr({
    @required int productId,
    @required List<int> attrId,
  }) async {
    assert(productId != null && productId > 0);
    assert(attrId != null && attrId.isNotEmpty);

    final url = '${ProductAPIs.getVariantByAttr}?product_id=$productId';

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
      body: json.encoder.convert({'attr_ids': attrId}),
    ));
  }

  static Future<SuperResponseModel> productByBarcode(String barcode) async {
    assert(barcode != null);

    return HttpHelper.simpleRequest(HttpHelper.post(
      HttpHelper.url(ProductAPIs.productByBarcode),
      header: await API.header(),
      body: json.encoder.convert({'barcode': barcode}),
    ));
  }

  static Future<SuperResponseModel> updateProductQty({
    @required int id,
    @required int qty,
  }) async {
    assert(id != null);
    assert(qty != null);

    return HttpHelper.simpleRequest(HttpHelper.post(
      HttpHelper.url(ProductAPIs.addProductQuantity),
      header: await API.header(),
      body: json.encoder.convert({'product_id': id, 'new_qty': qty}),
    ));
  }

  static Future<SuperResponseModel> variantList({
    VariantListParams params,
  }) async {
    var url = ProductAPIs.variantList;

    if (params != null) {
      url += params.parse;
    }

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
      body: json.encoder.convert(<String, dynamic>{}),
    ));
  }
}
