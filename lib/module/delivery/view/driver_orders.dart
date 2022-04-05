import 'package:branch_manager/module/delivery/cubit/type_of_order_screen_cubit/cubit.dart';
import 'package:branch_manager/module/order/controller/const.dart';
import 'package:branch_manager/module/order/model/orders_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../widget/default_body.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../chat/common/chat_view_imports.dart';
import 'driver_type_of_orders_view.dart';

class DriverOrdersView extends StatefulWidget {
  static const routeName = 'driver_orders_view';

  final int driverId;

  const DriverOrdersView(this.driverId)
      : assert(driverId != null, 'driver id must not be null');

  @override
  _DriverOrdersViewState createState() => _DriverOrdersViewState();
}

class _DriverOrdersViewState extends State<DriverOrdersView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabs = OrderStagesHelper.driverOrderTypeTabs
      .map((e) => Tab(child: Text(e.title)))
      .toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AuthListener(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(
          title: Text('ORDERS'.tr),
          bottom: TabBar(
            controller: _tabController,
            tabs: _tabs,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.white,
          ),
        ),
        body: DefaultBody(
          child: TabBarView(
            controller: _tabController,
            children: OrderStagesHelper.driverOrderTypeTabs.map((e) {
              return BlocProvider<DriverTypeOfOrdersViewCubit>(
                create: (context) {
                  return DriverTypeOfOrdersViewCubit(
                    param: OrdersListParam(
                      orderTypeParameter: e.orderTypeParameter,
                    ),
                    driverId: widget.driverId,
                  );
                },
                child: DriverTypeOfOrdersScreen(orderTypeTab: e),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
