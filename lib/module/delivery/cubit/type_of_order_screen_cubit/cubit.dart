import 'package:branch_manager/model/pagination.dart';
import 'package:branch_manager/module/delivery/repo/service.dart';
import 'package:branch_manager/module/order/model/orders_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/order/extension/order_list_extension.dart';
import '../../../../model/order/order.dart';
import '../../../../model/order/order_list.dart';

import 'cubit_extension.dart';
import 'states.dart';

class DriverTypeOfOrdersViewCubit extends Cubit<DriverTypeOgOrderScreenStates> {
  OrderList _orderList;
  OrdersListParam param;
  final int driverId;

  OrderList get orderList {
    return _orderList ?? const OrderList(count: 0, orders: <Order>[]);
  }

  DriverTypeOfOrdersViewCubit({
    @required this.param,
    @required this.driverId,
  }) : super(const InitialState()) {
    param = param.copyWith(offset: 0);
    init();
  }

  factory DriverTypeOfOrdersViewCubit.get(BuildContext context) {
    return BlocProvider.of<DriverTypeOfOrdersViewCubit>(context);
  }

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await DeliveryService.driverOrderList(
        driverId: driverId,
        status: param.orderTypeParameter,
        pagination: Pagination(
          offset: param.offset,
          limit: param.limit,
        ),
      );

      if (result is String) throw result;

      if (result is OrderList) {
        _orderList = result;

        if (_orderList == null || _orderList.empty) {
          emit(const EmptyState());
        } else {
          emit(const HasInitState());
        }
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> fetchMore() async {
    if (state is FetchingDataState) return;

    if (orderList.orders.length >= orderList.count) {
      return;
    }

    try {
      await Future<void>.delayed(Duration.zero); //to enable consumer

      emit(const FetchingDataState());

      increaseOffset();

      final Object result = await DeliveryService.driverOrderList(
        driverId: driverId,
        status: param.orderTypeParameter,
        pagination: Pagination(
          offset: param.offset,
          limit: param.limit,
        ),
      );

      if (result is String) throw result;

      if (result is OrderList) {
        _orderList?.orders?.addAll(result?.orders ?? []);
        emit(const HasInitState());
      }
    } catch (e) {
      decreaseOffset();
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    await Future<void>.delayed(Duration.zero);
    emit(const LoadingState());

    param = param.copyWith(offset: 0);
    await init();
  }
}
