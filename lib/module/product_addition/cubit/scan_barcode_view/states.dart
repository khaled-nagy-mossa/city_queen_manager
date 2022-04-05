import 'package:flutter/material.dart';

import '../../model/barcode_product.dart';

abstract class ScanBarcodeStates {
  const ScanBarcodeStates();
}

class InitialState extends ScanBarcodeStates {
  const InitialState() : super();
}

class LoadingState extends ScanBarcodeStates {
  const LoadingState() : super();
}

class BarcodeWasReadSuccessfully extends ScanBarcodeStates {
  final BarcodeProduct product;
  final String barcode;

  const BarcodeWasReadSuccessfully({
    @required this.product,
    @required this.barcode,
  })  : assert(product != null),
        assert(barcode != null),
        super();
}

class IneffectiveState extends ScanBarcodeStates {
  final String error;

  const IneffectiveState({@required this.error}) : super();
}
