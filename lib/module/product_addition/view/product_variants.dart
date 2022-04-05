import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_imports.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/custom_shadow.dart';
import '../../../widget/linear_progress_indicator.dart';
import '../../product/model/product.dart';
import '../../product/model/variant.dart';
import '../../product/widget/product_item.dart';
import '../../product/widget/variant_item.dart';
import '../cubit/product_variants/cubit.dart';
import '../cubit/product_variants/states.dart';

class ProductVariantsView extends StatelessWidget {
  const ProductVariantsView(
      {@required this.product, this.onSelectItem, Key key})
      : assert(product != null, 'product must not be null'),
        super(key: key);

  ///product id to call api and get all variants of this product
  final Product product;
  final void Function(Variant variant) onSelectItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductVariantsCubit>(
      create: (context) => ProductVariantsCubit(product: product),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ProductVariantsCubit, ProductVariantsStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                // AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              final cubit = ProductVariantsCubit.get(context);
              return Scaffold(
                appBar: DefaultAppBar(
                  title: Text('${product?.name} Variants'),
                  actions: const [],
                ),
                body: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: cubit.refresh,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        children: [
                          CustomShadow(
                            child: Container(
                              constraints: const BoxConstraints(),
                              height: MediaQuery.of(context).size.width - 100.0,
                              child: ProductItem(product: product),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Variants',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          _variants(context),
                        ],
                      ),
                    ),
                    if (state is LoadingState)
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: const AppLinearIndicator(),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _variants(BuildContext context) {
    final cubit = ProductVariantsCubit.get(context);
    if (cubit.variantList == null || cubit.variantList.unusable) {
      return Container();
    }
    return CustomShadow(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cubit?.variantList?.variants?.length ?? 0,
        itemBuilder: (context, index) {
          final variant = cubit?.variantList?.variants[index];
          return VariantItem(
            variant: variant,
            onTap: () {
              if (onSelectItem != null) {
                onSelectItem(variant);
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
