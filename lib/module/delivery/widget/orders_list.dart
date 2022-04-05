import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../model/order/order.dart';
import '../../order/view/order_view.dart';
import '../../order/widget/order_items_2.dart';
import 'in_delivery_orders_list_tile.dart';

class OrdersList extends StatelessWidget {
  final List<Order> orders;
  final VoidCallback onSeeAllTapped;

  const OrdersList({
    @required this.orders,
    this.onSeeAllTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orders == null || orders.isEmpty) return const SizedBox();
    return Column(
      children: [
        InDeliveryOrdersListTile(
          ordersCount: orders.length,
          onSeeAllTapped: onSeeAllTapped,
        ),
        const SizedBox(height: 5.0),
        ..._ordersList(context),
      ],
    );
  }

  List<Widget> _ordersList(BuildContext context) {
    final list = <Widget>[];
    for (final order in orders) {
      list.add(
        GestureDetector(
          onTap: () {
            AppRoutes.push(context, OrderView(order: order));
          },
          child: OrderDataNode(order: order),
        ),
      );
    }
    return list;
  }
}
