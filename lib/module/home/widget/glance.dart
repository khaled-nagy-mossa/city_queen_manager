import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../common/assets/assets.dart';
import '../../../main_imports.dart';
import '../../chat/common/chat_view_imports.dart';
import 'collected_money_item.dart';

class GlanceWidget extends StatelessWidget {
  final String online;
  final String inBranch;

  const GlanceWidget({
    @required this.online,
    @required this.inBranch,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AT_A_GLANCE'.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2.0),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: CollectedMoneyItem(
                    svgPath: Assets.images.add,
                    title: 'IN_BRANCH'.tr,
                    money: inBranch,
                  ),
                ),
                Expanded(
                  child: CollectedMoneyItem(
                    svgPath: Assets.images.add,
                    title: 'ONLINE'.tr,
                    money: online,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
