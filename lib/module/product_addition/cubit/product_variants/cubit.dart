import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/model/helper/variant_list_params.dart';
import '../../../product/model/product.dart';
import '../../../product/model/variant_list.dart';
import '../../../product/repositories/product_service.dart';
import 'states.dart';

class ProductVariantsCubit extends Cubit<ProductVariantsStates> {
  final Product product;
  VariantList variantList;

  ProductVariantsCubit({@required this.product})
      : assert(product != null),
        super(const InitialState()) {
    init();
  }

  factory ProductVariantsCubit.get(BuildContext context) {
    return BlocProvider?.of<ProductVariantsCubit>(context);
  }

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);
      emit(const LoadingState());

      final Object result = await ProductService.variantList(
        params: VariantListParams(productId: product.id),
      );
      if (result is VariantList) {
        variantList = result;
        emit(const HasInitState());
      } else {
        throw result.toString();
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    try {
      await Future<void>.delayed(Duration.zero);
      variantList = null;
      await init();
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
