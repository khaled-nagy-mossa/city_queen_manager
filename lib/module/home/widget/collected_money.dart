import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../common/assets/assets.dart';
import '../../chat/common/chat_view_imports.dart';
import 'collected_money_item.dart';

class CollectedMoneyWidget extends StatelessWidget {
  final String income;
  final String orders;

  const CollectedMoneyWidget({
    @required this.income,
    @required this.orders,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'EXPENDITURE_SUMMARY'.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 2.0),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: CollectedMoneyItem(
                  svgPath: Assets.images.income,
                  title: 'INCOME'.tr,
                  money: income,
                ),
              ),
              Expanded(
                child: CollectedMoneyItem(
                  svgPath: Assets.images.shoppingBag,
                  title: 'ORDERS'.tr,
                  money: orders,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
