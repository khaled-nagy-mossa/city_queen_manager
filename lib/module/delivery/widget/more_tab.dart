import 'package:branch_manager/module/delivery/model/orders_by_month.dart';
import 'package:flutter/material.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({@required this.orders, Key key}) : super(key: key);
  final OrdersByMonth orders;

  @override
  Widget build(BuildContext context) {
    if (orders == null) {
      return const SizedBox();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('More', style: Theme.of(context).textTheme.headline6),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: orders.ordersByMonth.length,
          itemBuilder: (context, index) {
            final order = orders.ordersByMonth[index];

            return Card(
              child: ListTile(
                title: Text(
                  'Orders',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  order.ordersCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(order.month),
              ),
            );
          },
        ),
      ],
    );
  }
}
