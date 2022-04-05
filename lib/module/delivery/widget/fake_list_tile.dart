import 'dart:developer';

import 'package:app_launcher/app_launcher.dart';
import 'package:app_routes/app_routes.dart';
import 'package:branch_manager/common/config/api.dart';
import 'package:branch_manager/main_imports.dart';
import 'package:branch_manager/module/chat/view/conversation.dart';
import 'package:branch_manager/module/delivery/model/delivery.dart';
import 'package:branch_manager/module/delivery/view/delivery.dart';
import 'package:branch_manager/widget/custom_shadow.dart';
import 'package:flutter/material.dart';

import 'list_tile_action.dart';

///
class DeliveryFakeListTile extends StatelessWidget {
  ///
  DeliveryFakeListTile({@required this.delivery, this.onSelect, Key key})
      : assert(delivery != null, 'delivery must not be null'),
        super(key: key);

  final Delivery delivery;
  final VoidCallback onSelect;

  bool _startingChatRunningNow = false;

  Future<void> _startChat(BuildContext context) async {
    if (_startingChatRunningNow) return;
    _startingChatRunningNow = true;

    final cubit = ChatCubit.get(context);

    final conversation = await cubit.startChatWith(
      ChatUser(
        id: delivery.id.toString(),
        name: delivery.name,
        avatar: API.imageUrl(delivery.image),
      ),
    );
    if (conversation != null && conversation.usable) {
      await AppRoutes.push(
        context,
        ConversationView(conversation: conversation),
      );
    }
  }

  String _subTitle() {
    final inDeliveryOrders = delivery.totalInDeliveryOrders;
    final totalOrders = delivery.totalOrders;

    if (inDeliveryOrders != 0 && inDeliveryOrders != null) {
      return 'In Delivery Orders $inDeliveryOrders';
    } else if (totalOrders != 0 && totalOrders != null) {
      return 'Total Orders : $totalOrders';
    } else {
      return delivery.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomShadow(
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          onTap: () {
            AppRoutes.push(context, DeliveryView(driverId: delivery.id));
          },
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 55.0,
            width: 55.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(API.imageUrl(delivery.image)),
              ),
            ),
          ),
          title: Text(
            delivery.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            _subTitle(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: onSelect == null
              ? IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTileAction(
                        onTap: () {
                          AppLauncher.launchToPhone(delivery.phone);
                        },
                        svg: Assets.images.telephone,
                        hint: 'Call Delivery',
                      ),
                      ListTileAction(
                        onTap: () {
                          _startChat(context);
                        },
                        svg: Assets.images.chat,
                        hint: 'Start Chat',
                      ),
                    ],
                  ),
                )
              : ListTileAction(
                  onTap: onSelect,
                  svg: Assets.images.select,
                  hint: 'Select Delivery',
                ),
        ),
      ),
    );
  }
}
