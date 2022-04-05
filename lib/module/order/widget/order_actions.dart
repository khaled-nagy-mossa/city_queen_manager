import 'package:branch_manager/module/order/controller/const.dart';
import 'package:branch_manager/module/order/model/order_type_tab_model.dart';
import 'package:flutter/material.dart';

class OrderStagesButton extends StatelessWidget {
  const OrderStagesButton(
      {@required this.status, @required this.changeState, Key key})
      : super(key: key);
  final String status;

  final void Function(OrderTypeTapModel newStage) changeState;

  @override
  Widget build(BuildContext context) {
    if (status == null) {
      return const SizedBox();
    }
    final orderType = OrderStagesHelper.orderTypeBy(orderTypeParameter: status);
    if (orderType == null) {
      return const SizedBox();
    }
    final next = OrderStagesHelper.nextStage(orderType: orderType.orderType);
    if (next == null) {
      return const SizedBox();
    }

    if (next.orderType == OrderType.all || next.orderType == OrderType.cancel) {
      return const SizedBox();
    }
    return ElevatedButton(
      onPressed: () {
        changeState(next);
      },
      child: Text(next.title.toString()),
    );
  }
}
