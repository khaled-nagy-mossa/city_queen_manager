import 'package:branch_manager/main_imports.dart';
import 'package:branch_manager/module/delivery/model/order_label.dart';
import 'package:branch_manager/module/delivery/service/order_label.dart';
import 'package:flutter/material.dart';

class OldMoreTab extends StatelessWidget {
  const OldMoreTab({
    @required this.labels,
    Key key,
  })  : assert(labels != null),
        super(key: key);

  final List<OrderLabel> labels;

  @override
  Widget build(BuildContext context) {
    final list = OrderLabelService.orderLabelByMonth(labels);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('More', style: Theme.of(context).textTheme.headline6),
        ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
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
                  list[index].ordersCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  '${list[index].label.month}-${list[index].label.year}',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
