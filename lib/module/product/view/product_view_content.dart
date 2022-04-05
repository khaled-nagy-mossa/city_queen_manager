import 'package:branch_manager/module/product/widget/stock.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../main_imports.dart';
import '../../global/view/exception_view.dart';
import '../../review/widget/review_list.dart';
import '../cubit/product/product_cubit.dart';
import '../cubit/variant/variant_cubit.dart';
import '../widget/product_main_data.dart';
import '../widget/product_rate.dart';
import '../widget/product_sliver_app_bar.dart';
import 'product_description_view.dart';

class ProductViewContent extends StatefulWidget {
  final int productId;

  const ProductViewContent({
    @required this.productId,
  }) : assert(productId != null);

  @override
  _ProductViewContentState createState() => _ProductViewContentState();
}

class _ProductViewContentState extends State<ProductViewContent>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  static final _tabs = <Tab>[
    Tab(child: Text('Description'.tr)),
    Tab(child: Text('Reviews'.tr)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  bool get wantKeepAlive => true;

  double get _horizontalPadding => 15.0;

  Widget get _itemPadding => const SizedBox(height: 22.0);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final pCubit = ProductViewCubit.get(context);
    final vCubit = VariantCubit.get(context);
    final scSize = MediaQuery.of(context).size;

    try {
      return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              ProductSliverAppBar(variant: vCubit.variant),
            ];
          },
          body: Container(
            constraints: const BoxConstraints(),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductMainData(variant: vCubit.variant),
                      _itemPadding,
                      Row(
                        children: [
                          ProductRate(
                            ratingAvg:
                                pCubit?.product?.reviews?.ratingAvg ?? 0.0,
                          ),
                          const SizedBox(width: 20.0),
                          Stock(
                            count: pCubit?.product?.defaultVariant
                                ?.countInStock(
                                    AccountCubit.get(context).user?.branch?.id),
                          ),
                        ],
                      ),
                      _itemPadding,
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: scSize.height - 70.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: _horizontalPadding - 7.0,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          tabs: _tabs,
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          labelColor: Colors.white,
                          indicator: BubbleTabIndicator(
                            indicatorHeight: 40.0,
                            indicatorColor: Theme.of(context).primaryColor,
                            indicatorRadius: 15.0,
                            tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            SingleChildScrollView(
                              padding: EdgeInsets.only(
                                bottom: 70.0,
                                left: _horizontalPadding,
                                right: _horizontalPadding,
                              ),
                              child: ProductDescriptionView(
                                currentVariant: vCubit.variant,
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 10.0),
                                  ReviewList(
                                    product: pCubit.product,
                                    reviewList: pCubit?.product?.reviews,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      return ExceptionView(
        onRefresh: () async {
          await pCubit.refresh(widget.productId);
        },
        exceptionMsg: e.toString(),
      );
    }
  }
}
