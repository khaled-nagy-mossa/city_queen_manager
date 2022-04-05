import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../main_imports.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/default_body.dart';
import '../../../widget/gradient_text.dart';
import '../../../widget/loading_widget.dart';
import '../cubit/add_product_qty_view/cubit.dart';
import '../cubit/add_product_qty_view/states.dart';
import '../model/barcode_product.dart';
import '../widget/product_image.dart';
import '../widget/product_qty_counter.dart';
import 'qty_updated.dart';

class AddProductQuantity extends StatelessWidget {
  final BarcodeProduct product;
  final String barcode;

  const AddProductQuantity({@required this.product, this.barcode, Key key})
      : assert(product != null),
        super(key: key);

  EdgeInsets get scPadding {
    return const EdgeInsets.fromLTRB(18.0, 30.0, 18.0, 40.0);
  }

  String get _price {
    final variant = product?.variant;

    final price = variant?.price?.toString();
    if (price == null) return '';

    final currency = variant?.currency ?? variant?.currencySymbol;
    if (currency == null) return price;

    return '$price $currency';
  }

  @override
  Widget build(BuildContext context) {
    if (product == null || product.unusable) return const Scaffold();

    return BlocProvider<AddProductQtyCubit>(
      create: (context) => AddProductQtyCubit(product: product),
      child: Builder(
        builder: (context) {
          return BlocConsumer<AddProductQtyCubit, AddProductQtyStates>(
            listener: (context, state) {
              if (state is IneffectiveState) {
                AppSnackBar.error(context, state.error ?? 'Unknown Error'.tr);
              } else if (state is QtyUpdatedState) {
                AppRoutes.push(context, const ProductQtyUpdatedView());
              }
            },
            builder: (context, state) {
              final cubit = AddProductQtyCubit.get(context);

              return Scaffold(
                appBar: DefaultAppBar(title: Text('ADD_PRODUCT'.tr)),
                body: DefaultBody(
                  child: Stack(
                    children: [
                      Container(
                        constraints: const BoxConstraints.expand(),
                        padding: scPadding,
                        child: Column(
                          children: [
                            ProductImage(product: product),
                            const SizedBox(height: 40.0),
                            Text(
                              product?.productName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 14.0),
                            GradientText(
                              text: Text(
                                _price,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              gradient: AppData.gradient,
                            ),
                          ],
                        ),
                      ),
                      if (state is LoadingState) const LoadingWidget(),
                    ],
                  ),
                ),
                bottomNavigationBar: ProductQtyCounter(
                  initialValue: cubit.product.qtyAvailable.floor(),
                  onTap: (counter) {
                    cubit.updateQuantity(counter);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
