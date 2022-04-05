import 'package:branch_manager/main_imports.dart';
import 'package:branch_manager/module/delivery/model/delivery.dart';
import 'package:branch_manager/module/delivery/widget/fake_list_tile.dart';
import 'package:branch_manager/module/delivery/widget/toggle.dart';
import 'package:branch_manager/widget/app_snack_bar/app_snack_bar.dart';
import 'package:branch_manager/widget/linear_progress_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:branch_manager/module/delivery/cubit/deliveries/cubit.dart';
import 'package:branch_manager/module/delivery/cubit/deliveries/states.dart';
import 'package:branch_manager/widget/app_bar/default_app_bar.dart';
import 'package:branch_manager/widget/default_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class DeliveriesView extends StatelessWidget {
  const DeliveriesView({this.onSelectDelivery, Key key}) : super(key: key);
  final void Function(Delivery delivery) onSelectDelivery;
  static const routeName = 'drivers';

  @override
  Widget build(BuildContext context) {
    int _currentSelectedItem = 0;
    return BlocProvider<DeliveriesCubit>(
      create: (context) => DeliveriesCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<DeliveriesCubit, DeliveriesStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              final cubit = DeliveriesCubit.get(context);

              return Scaffold(
                appBar: DefaultAppBar(title: Text('DELIVERY_MEN'.tr)),
                body: DefaultBody(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ToggleWidget(
                                  title: 'ALL'.tr,
                                  onTap: () {
                                    _currentSelectedItem = 0;
                                    cubit.fetchData(hasOrders: null);
                                  },
                                  selected: _currentSelectedItem == 0,
                                ),
                                ToggleWidget(
                                  title: 'HAVE_ORDERS'.tr,
                                  onTap: () {
                                    _currentSelectedItem = 1;
                                    cubit.fetchData();
                                  },
                                  selected: _currentSelectedItem == 1,
                                ),
                                ToggleWidget(
                                  title: "HAVENT_ORDERS".tr,
                                  onTap: () {
                                    _currentSelectedItem = 2;
                                    cubit.fetchData(hasOrders: false);
                                  },
                                  selected: _currentSelectedItem == 2,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 20.0, 10.0, 70.0),
                              itemCount:
                                  cubit?.deliveryList?.drivers?.length ?? 0,
                              itemBuilder: (context, index) {
                                final driver =
                                    cubit?.deliveryList?.drivers[index];

                                return DeliveryFakeListTile(
                                  delivery: driver,
                                  onSelect: onSelectDelivery == null
                                      ? null
                                      : () => onSelectDelivery(driver),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      if (state is FetchingDataState)
                        const AppLinearIndicator(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
