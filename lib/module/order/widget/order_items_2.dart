import 'package:flutter/material.dart';

import '../../../model/order/order.dart';
import '../../../widget/custom_shadow.dart';
import 'order_item_address.dart';
import 'order_list_tile_data.dart';

class OrderDataNode extends StatelessWidget {
  final Order order;

  const OrderDataNode({@required this.order});

  @override
  Widget build(BuildContext context) {
    if (order == null || order.unusable) return const SizedBox();
    return CustomShadow(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderListTileData(order: order),
              OrderItemAddress(order: order),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
