import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../product_addition/model/barcode_product.dart';
import '../model/helper/product_list_params.dart';
import '../model/helper/variant_list_params.dart';
import '../model/product.dart';
import '../model/product_list.dart';
import '../model/variant.dart';
import '../model/variant_list.dart';
import 'product_repo.dart';

abstract class ProductService {
  const ProductService();

  static Future productList({ProductListParams params}) async {
    try {
      final res = await ProductRepo.productList(params: params);

      if (res.hasError) return res.msg;

      return ProductList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ProductService.productList : $e');
      return e.toString();
    }
  }

  static Future variantList({VariantListParams params}) async {
    try {
      final res = await ProductRepo.variantList(params: params);

      if (res.hasError) return res.msg;

      return VariantList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ProductService.productList : $e');
      return e.toString();
    }
  }

  static Future productById(int id) async {
    assert(id != null);

    try {
      final res = await ProductRepo.productById(id);

      if (res.hasError) throw res.msg;

      return Product.fromMap(
        res.json['result']['product'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in ProductService.productById : $e');
      return e.toString();
    }
  }

  static Future variantByAttributes({
    @required int productId,
    @required List<int> attrId,
  }) async {
    assert(productId != null && productId > 0);
    assert(attrId != null && attrId.isNotEmpty);

    try {
      final res = await ProductRepo.getVariantByAttr(
        productId: productId,
        attrId: attrId,
      );

      if (res.hasError) throw res.msg;

      return Variant.fromMap(
        res.json['result']['variant'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in ProductService.variantByAttributes : $e');
      return e.toString();
    }
  }

  static Future productByBarcode(String barcode) async {
    assert(barcode != null);

    try {
      final res = await ProductRepo.productByBarcode(barcode);

      if (res.hasError) throw res.msg;

      return BarcodeProduct.fromMap(
        res.json['result'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in ProductService.productByBarcode : $e');
      return e.toString();
    }
  }

  //////legacy cody ...yaaaa3
  static Future<String> updateProductQty({
    @required int id,
    @required int qty,
  }) async {
    assert(id != null);
    assert(qty != null);

    try {
      final res = await ProductRepo.updateProductQty(id: id, qty: qty);

      /// bad backend code
      /// He broke the canonical structure
      try {
        if (res.hasError) throw res.msg;
      } catch (e) {
        log('');
      }

      final msg = json.decode(res.res.body)['result'] as String;

      if (res.res.statusCode == 200 && msg != null) {
        return msg;
      }

      throw 'UnKnown Problem';
    } catch (e) {
      log('Exception in ProductService.updateProductQty : $e');
      return e.toString();
    }
  }
}
