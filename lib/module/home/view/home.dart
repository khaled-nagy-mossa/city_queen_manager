import 'package:app_routes/app_routes.dart';
import 'package:branch_manager/module/order/view/order_view.dart';
import 'package:branch_manager/module/order/widget/order_items_2.dart';
import 'package:branch_manager/shared_widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../main_imports.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/default_body.dart';
import '../../../widget/loading_widget.dart';
import '../../global/widget/exception.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../widget/chart.dart';
import '../widget/collected_money.dart';
import '../widget/glance.dart';
import '../widget/welcome.dart';

class HomeView extends StatelessWidget {
  static const routeName = 'home_view';

  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewCubit>(
      create: (context) => HomeViewCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<HomeViewCubit, HomeViewStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              return Scaffold(
                drawer: const DrawerWidget(),
                appBar: const DefaultAppBar(
                  bottom: PreferredSize(
                    preferredSize: Size(double.infinity, 100.0),
                    child: WelcomeWidget(),
                  ),
                ),
                body: DefaultBody(
                  child: Stack(
                    children: [
                      _body(context, state),
                      if (state is RefreshState) const LoadingWidget(),
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

  Widget _body(BuildContext context, HomeViewStates state) {
    final cubit = HomeViewCubit.get(context);
    if (state is InitialState) {
      return const LoadingWidget(color: Colors.transparent);
    } else if (state is ExceptionState) {
      return ExceptionWidget(
        onRefresh: cubit.refresh,
        exceptionMsg: state.error,
      );
    } else {
      return RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
          children: [
            CollectedMoneyWidget(
              income: cubit.model.income,
              orders: cubit.model.orders,
            ),
            const SizedBox(height: 14.0),
            ChartWidget(orders: cubit?.model?.orderLabels ?? []),
            const SizedBox(height: 14.0),
            GlanceWidget(
              inBranch: cubit?.model?.glance?.inBranch ?? '',
              online: cubit?.model?.glance?.online ?? '',
            ),
            const SizedBox(height: 20.0),
            Text('NEW_ORDERS'.tr, style: Theme.of(context).textTheme.headline6),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubit?.model?.newOrders?.length ?? 0,
              itemBuilder: (context, index) {
                final order = cubit?.model?.newOrders[index];
                return GestureDetector(
                  onTap: () {
                    AppRoutes.push(context, OrderView(order: order));
                  },
                  child: OrderDataNode(order: order),
                );
              },
            ),
          ],
        ),
      );
    }
  }
}
