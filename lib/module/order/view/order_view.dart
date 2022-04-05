import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:branch_manager/main_imports.dart';
import 'package:branch_manager/module/delivery/view/deliveries.dart';
import 'package:branch_manager/module/order/widget/order_customer.dart';
import 'package:branch_manager/widget/app_bar/default_app_bar.dart';
import 'package:branch_manager/widget/default_body.dart';
import 'package:branch_manager/widget/map_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/assets/assets.dart';
import '../../../model/order/order.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../global/widget/exception.dart';
import '../controller/const.dart';
import '../cubit/order_view/cubit.dart';
import '../cubit/order_view/states.dart';
import '../widget/order_actions.dart';
import '../widget/order_delivery.dart';
import '../widget/order_items_2.dart';
import '../widget/order_lines.dart';
import '../widget/order_price_details.dart';

class OrderView extends StatelessWidget {
  static const id = 'order_view';

  final Order order;
  final int orderId;

  const OrderView({this.order, this.orderId})
      : assert(order != null || orderId != null);

  @override
  Widget build(BuildContext context) {
    return AuthListener(
      child: BlocProvider<OrderViewCubit>(
        create: (context) => OrderViewCubit(order: order, orderId: orderId),
        child: BlocConsumer<OrderViewCubit, OrderViewStates>(
          listener: (context, state) {
            if (state is IneffectiveErrorState) {
              AppSnackBar.error(context, state.error);
            } else if (state is OrderDeliveryManUpdatedState) {
              log(state.order.toMap().toString());
            }
          },
          builder: (context, state) {
            final order = OrderViewCubit.get(context).order;
            return Stack(
              children: [
                Scaffold(
                  appBar: DefaultAppBar(
                    title: Text('Order #${order.id}'.tr),
                  ),
                  body: DefaultBody(child: _body(context, state)),
                ),
                if (state is LoadingState) const LoadingWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget get _sizedBox => const SizedBox(height: 10.0);

  Widget _body(BuildContext context, OrderViewStates state) {
    final cubit = OrderViewCubit.get(context);
    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is ExceptionState) {
      return ExceptionWidget(
        onRefresh: cubit.refresh,
        exceptionMsg: state.error,
        imagePath: Assets.images.orders,
      );
    } else {
      return RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 70.0),
          children: [
            Text('ORDERS'.tr, style: Theme.of(context).textTheme.headline6),
            _sizedBox,
            OrderDataNode(order: cubit.order),
            _sizedBox,
            _sizedBox,
            OrderCustomerListTile(customer: cubit?.order?.customer),
            _sizedBox,
            _sizedBox,
            OrderDeliveryListTile(delivery: cubit?.order?.deliveryMan),
            _sizedBox,
            _sizedBox,
            Text('Order Details', style: Theme.of(context).textTheme.headline6),
            _sizedBox,
            OrderLines(lines: cubit?.order?.lines ?? []),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: OrderPriceDetails(order: cubit.order),
            ),
            OrderStagesButton(
              status: cubit?.order?.status,
              changeState: (stage) async {
                if (stage.orderType == OrderType.inDelivery) {
                  await AppRoutes.push(
                    context,
                    DeliveriesView(
                      onSelectDelivery: (driver) async {
                        AppRoutes.pop(context);
                        await cubit.updateOrderDeliveryMan(driver);
                        await cubit.refresh();
                      },
                    ),
                  );
                } else {
                  await cubit.updateOrderStage(
                    stage.orderTypeParameter.toLowerCase(),
                  );
                }
              },
            ),
            if (cubit.order.status == 'in_delivery') ...[
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: const Text(
                  'Current Delivery Man Location',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(height: 10.0),
              MapBox(
                size: const Size(0.0, 200.0),
                markLocation: LatLng(
                  cubit?.order?.deliveryMan?.currentLocation?.lat ?? 0.0,
                  cubit?.order?.deliveryMan?.currentLocation?.lng ?? 0.0,
                ),
              ),
            ]
          ],
        ),
      );
    }
  }
}
