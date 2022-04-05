import 'package:app_routes/app_routes.dart';
import 'package:branch_manager/module/product_addition/view/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../main_imports.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/default_body.dart';
import '../../../widget/loading_widget.dart';
import '../../product/view/search.dart';
import '../cubit/scan_barcode_view/cubit.dart';
import '../cubit/scan_barcode_view/states.dart';
import '../widget/add_product_view_body.dart';
import '../widget/add_product_view_fab.dart';
import '../widget/add_product_view_field.dart';
import 'add_product_quantity.dart';
import 'product_variants.dart';

class ScanProductBarcodeView extends StatelessWidget {
  static const routeName = 'scan_product_barcode_view';

  const ScanProductBarcodeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBarcodeCubit>(
      create: (context) => ProductBarcodeCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ProductBarcodeCubit, ScanBarcodeStates>(
            listener: (context, state) {
              if (state is IneffectiveState) {
                AppSnackBar.error(context, state.error ?? 'Unknown Error'.tr);
              } else if (state is BarcodeWasReadSuccessfully) {
                AppRoutes.push(
                  context,
                  AddProductQuantity(
                    product: state.product,
                    barcode: state.barcode,
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = ProductBarcodeCubit.get(context);

              return Scaffold(
                appBar: DefaultAppBar(
                  title: Text('ADD_PRODUCT'.tr),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.history),
                      color: Colors.white,
                      onPressed: () {
                        AppRoutes.push(context, const VariantHistoryView());
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        AppRoutes.push(
                          context,
                          SearchView(
                            onSelectItem: (product) {
                              AppRoutes.pop(context);
                              AppRoutes.push(
                                context,
                                ProductVariantsView(
                                  product: product,
                                  onSelectItem: (variant) {},
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 50.0,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        color: Colors.transparent,
                        child: SvgPicture.asset(
                          Assets.images.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                body: DefaultBody(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(
                          10.0,
                          20.0,
                          10.0,
                          40.0,
                        ),
                        child: Column(
                          children: [
                            AddProductViewField(
                              controller: cubit.fieldController,
                            ),
                            AddProductViewBody(
                              onTap: () async {
                                await cubit.scanBarcode();
                                await cubit.searchByBarcode();
                              },
                            ),
                          ],
                        ),
                      ),
                      if (state is LoadingState) const LoadingWidget(),
                    ],
                  ),
                ),
                floatingActionButton: AddProductViewFAB(
                  onTap: () {
                    cubit.searchByBarcode();
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
