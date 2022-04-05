import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:branch_manager/module/delivery/widget/chart.dart';
import 'package:branch_manager/module/delivery/widget/fake_list_tile.dart';
import 'package:branch_manager/module/delivery/widget/orders_data_item.dart';
import 'package:branch_manager/module/delivery/widget/orders_list.dart';
import 'package:branch_manager/module/global/view/exception_view.dart';
import 'package:branch_manager/widget/app_bar/default_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:branch_manager/module/delivery/cubit/delivery/cubit.dart';
import 'package:branch_manager/module/delivery/cubit/delivery/states.dart';
import 'package:branch_manager/widget/app_snack_bar/app_snack_bar.dart';
import 'package:branch_manager/widget/default_body.dart';
import 'package:flutter/material.dart';
import 'package:branch_manager/widget/loading_widget.dart';

import 'driver_orders.dart';
import 'driver_statistics.dart';

class DeliveryView extends StatelessWidget {
  const DeliveryView({@required this.driverId, Key key})
      : assert(driverId != null, 'driverId must not be null'),
        super(key: key);

  ///
  final int driverId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeliveryCubit>(
      create: (context) => DeliveryCubit(deliveryId: driverId),
      child: Builder(
        builder: (context) {
          return BlocConsumer<DeliveryCubit, DeliveryStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              final cubit = DeliveryCubit.get(context);

              if (state is FetchingDataState || state is InitialState) {
                return const Scaffold(body: LoadingWidget(color: Colors.white));
              } else if (state is IneffectiveErrorState) {
                return ExceptionView(
                  exceptionMsg: state.error,
                  title: '',
                );
              }

              return Scaffold(
                appBar: DefaultAppBar(title: Text(cubit.profile.name ?? '')),
                body: DefaultBody(
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    children: [
                      DeliveryFakeListTile(delivery: cubit.profile.profileData),
                      const SizedBox(height: 20.0),
                      Text(
                        'Orders',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            OrdersDataItem(
                              title: 'In Delivery',
                              number: cubit
                                  .profile.profileData.totalInDeliveryOrders,
                            ),
                            OrdersDataItem(
                              title: 'Done',
                              number: cubit.profile.profileData.totalOrders -
                                  cubit.profile.profileData
                                      .totalInDeliveryOrders,
                            ),
                            OrdersDataItem(
                              title: 'All Orders',
                              number: cubit.profile.profileData.totalOrders,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ChartWidget(
                        orders: cubit.profile.counts,
                        onTap: () {
                          AppRoutes.push(
                            context,
                            DriverStatistics(profile: cubit.profile),
                          );
                        },
                      ),
                      OrdersList(
                        orders:
                            cubit.profile.profileData.latestInDeliveryOrders,
                        onSeeAllTapped: () {
                          AppRoutes.push(
                            context,
                            DriverOrdersView(driverId),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
