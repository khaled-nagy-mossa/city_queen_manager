import 'package:branch_manager/module/delivery/cubit/delivery/cubit.dart';
import 'package:branch_manager/module/delivery/cubit/delivery/states.dart';
import 'package:branch_manager/module/delivery/widget/chart_with_month.dart';
import 'package:branch_manager/module/delivery/widget/collected_money.dart';
import 'package:branch_manager/module/delivery/widget/date_picker.dart';
import 'package:branch_manager/module/delivery/widget/more_tab.dart';
import 'package:branch_manager/module/global/view/exception_view.dart';
import 'package:branch_manager/widget/app_bar/default_app_bar.dart';
import 'package:branch_manager/widget/app_snack_bar/app_snack_bar.dart';
import 'package:branch_manager/widget/default_body.dart';
import 'package:branch_manager/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../model/driver_profile.dart';

class DriverStatistics extends StatelessWidget {
  const DriverStatistics({@required this.profile, Key key}) : super(key: key);

  final DriverProfile profile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeliveryCubit>(
      create: (context) => DeliveryCubit(profile: profile),
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
                appBar: DefaultAppBar(
                  title: Text('${profile.name} Statistics'.tr),
                ),
                body: DefaultBody(
                  child: Stack(
                    children: [
                      ListView(
                        padding: const EdgeInsets.all(10.0),
                        children: [
                          CollectedMoneyWidget(
                            totalCollected: cubit.profile.totalCollected,
                            totalEarning: cubit.profile.totalEarning,
                          ),
                          const SizedBox(height: 20.0),
                          DatePickerWidget(
                            from: cubit.startMonth,
                            to: cubit.endMonth,
                            onChanged: cubit.changeDuration,
                          ),
                          ChartWithMonthWidget(
                            orders:
                                cubit?.profile?.ordersByMonth?.ordersByMonth,
                          ),
                          const SizedBox(height: 20.0),
                          // OldMoreTab(labels: cubit.profile.counts),
                          MoreTab(orders: cubit.profile.ordersByMonth),
                        ],
                      ),
                      if (state is LoadingState) const LoadingWidget(),
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
