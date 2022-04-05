import 'package:branch_manager/module/chat/common/chat_view_imports.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/const/app_data.dart';
import '../../../main_imports.dart';
import '../model/order_label.dart';

class ChartWidget extends StatelessWidget {
  final List<OrderLabel> orders;

  const ChartWidget({this.orders, this.onTap, Key key}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (orders == null || orders.isEmpty) return const SizedBox();

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<OrderLabel, String>>[
          LineSeries<OrderLabel, String>(
            dataSource: orders,
            xValueMapper: (order, _) {
              return '${order.label.day}-${order.label.month}';
            },
            yValueMapper: (order, _) {
              return order.ordersCount;
            },
          )
        ],
        title: ChartTitle(
          text: onTap == null ? 'Number Of Orders' : 'Show All Statistics',
          alignment: ChartAlignment.near,
          textStyle: const TextStyle(
            color: AppData.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
