import 'package:bloc/bloc.dart';
import 'package:branch_manager/module/product/model/variant_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main_imports.dart';
import '../../../product/model/helper/variant_list_params.dart';
import '../../../product/repositories/product_service.dart';
import 'states.dart';

class VariantHistoryCubit extends Cubit<VariantHistoryStates> {
  VariantHistoryCubit() : super(const InitState()) {
    fetchData();
  }

  VariantList _variantList = const VariantList(count: 0, variants: []);

  VariantList get variantList => _variantList;

  VariantListParams _params = const VariantListParams(offset: -1);

  factory VariantHistoryCubit.get(BuildContext context) {
    return BlocProvider.of<VariantHistoryCubit>(context);
  }

  Future<void> fetchData() async {
    try {
      await Future.delayed(Duration.zero);
      emit(const FetchingDataState());

      _increaseOffset();

      final result = await ProductService.variantList(params: _params);

      if (result is VariantList) {
        _variantList = result;
      } else {
        throw result;
      }

      emit(const FetchedDataState());
    } catch (e) {
      _decreaseOffset();
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    try {
      _resetOffset();
      _variantList = const VariantList(count: 0, variants: []);
      await fetchData();
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  void _increaseOffset() {
    _params = _params.copyWith(offset: (_params?.offset ?? -20) + 20);
  }

  void _decreaseOffset() {
    _params = _params.copyWith(offset: (_params?.offset ?? 20) - 20);
  }

  void _resetOffset() {
    _params = _params.copyWith(offset: 0);
  }
}
