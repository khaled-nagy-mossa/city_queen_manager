import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/repositories/product_service.dart';
import '../../model/barcode_product.dart';
import 'states.dart';

class ProductBarcodeCubit extends Cubit<ScanBarcodeStates> {
  final fieldController = TextEditingController();
  String _barCode;

  ProductBarcodeCubit() : super(const InitialState()) {
    _setupFieldControllerListener();
  }

  factory ProductBarcodeCubit.get(BuildContext context) {
    return BlocProvider?.of<ProductBarcodeCubit>(context);
  }

  Future<void> scanBarcode() async {
    try {
      barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      emit(const IneffectiveState(
        error: 'Platform Exception Failed to get platform version.',
      ));
    } catch (e) {
      emit(IneffectiveState(error: e.toString()));
    }
  }

  Future<void> searchByBarcode() async {
    try {
      if (state is LoadingState) return;

      await Future<void>.delayed(Duration.zero);
      if (!_barcodeValidated) throw 'Invalid Barcode';
      emit(const LoadingState());

      final Object result = await ProductService.productByBarcode(_barCode);

      if (result is! BarcodeProduct) throw result.toString();

      if (result is BarcodeProduct) {
        emit(BarcodeWasReadSuccessfully(product: result, barcode: barcode));
        return;
      }
    } catch (e) {
      emit(IneffectiveState(error: e.toString()));
    }
  }

  bool get _barcodeValidated {
    try {
      return _barCode != null && _barCode.length > 5;
    } catch (e) {
      log('Exception in ProductBarcodeCubit._barcodeValidated : $e');
      return false;
    }
  }

  String get barcode {
    return _barCode;
  }

  set barcode(String value) {
    _barCode = value;
    fieldController.text = value;
  }

  ///to listen If its controller.text changes,
  ///it will be changed in all places listening to this event
  void _setupFieldControllerListener() {
    fieldController.addListener(() => _barCode = fieldController.text);
  }
}
