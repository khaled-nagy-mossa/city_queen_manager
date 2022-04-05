import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import '../../product/model/variant.dart';

class BarcodeProduct implements UsageCriteria {
  const BarcodeProduct({
    this.productId,
    this.productName,
    this.qtyAvailable,
    this.variant,
  });

  final int productId;
  final String productName;
  final double qtyAvailable;
  final Variant variant;

  BarcodeProduct copyWith({
    int productId,
    String productName,
    double qtyAvailable,
    Variant variant,
  }) {
    try {
      return BarcodeProduct(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        qtyAvailable: qtyAvailable ?? this.qtyAvailable,
        variant: variant ?? this.variant,
      );
    } catch (e) {
      log('Exception in BarcodeProduct.copyWith : $e');
      return this;
    }
  }

  factory BarcodeProduct.fromJson(String str) {
    try {
      if (str == null || str.length == null) return const BarcodeProduct();

      return BarcodeProduct.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in BarcodeProduct.fromJson : $e');
      return const BarcodeProduct();
    }
  }

  String toJson() => json.encode(toMap());

  factory BarcodeProduct.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const BarcodeProduct();

      return BarcodeProduct(
          productId: json['product_id'] as int,
          productName: json['product_name'] as String,
          qtyAvailable: (json['qty_available'] ?? 0.0) as double,
          variant: json['variant_model'] == null
              ? null
              : Variant.fromMap(json['variant_model'] as Map<String, dynamic>));
    } catch (e) {
      log('Exception in BarcodeProduct.fromMap : $e');
      return const BarcodeProduct();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'product_id': productId,
        'product_name': productName,
        'qty_available': qtyAvailable,
        'variant_model': variant?.toMap(),
      };
    } catch (e) {
      log('Exception in BarcodeProduct.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in BarcodeProduct.unusable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return productName != null && productId != null;
    } catch (e) {
      log('Exception in BarcodeProduct.usable : $e');
      return false;
    }
  }
}
