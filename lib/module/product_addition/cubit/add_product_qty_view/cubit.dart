
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/repositories/product_service.dart';
import '../../model/barcode_product.dart';
import 'states.dart';

class AddProductQtyCubit extends Cubit<AddProductQtyStates> {
  final BarcodeProduct product;

  AddProductQtyCubit({@required this.product})
      : assert(product != null),
        super(const InitialState());

  factory AddProductQtyCubit.get(BuildContext context) {
    return BlocProvider?.of<AddProductQtyCubit>(context);
  }

  Future<void> updateQuantity(int qty) async {
    try {
      await Future<void>.delayed(Duration.zero);
      emit(const LoadingState());

      final result = await ProductService.updateProductQty(
        id: product.productId,
        qty: qty,
      );

      if (result == "{'Quantity Successfully Updated.'}") {
        emit(QtyUpdatedState(msg: result));
      } else {
        throw result;
      }
    } catch (e) {
      emit(IneffectiveState(error: e.toString()));
    }
  }
}
