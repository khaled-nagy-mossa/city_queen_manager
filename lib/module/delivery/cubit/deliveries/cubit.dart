import 'package:branch_manager/model/pagination.dart';
import 'package:branch_manager/module/delivery/cubit/deliveries/states.dart';
import 'package:bloc/bloc.dart';
import 'package:branch_manager/module/delivery/model/delivery_list.dart';
import 'package:branch_manager/module/delivery/repo/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DeliveriesCubit extends Cubit<DeliveriesStates> {
  DeliveriesCubit() : super(const InitialState()) {
    fetchData();
  }

  DeliveryList deliveryList;

  factory DeliveriesCubit.get(BuildContext context) {
    return BlocProvider.of<DeliveriesCubit>(context);
  }

  Future<void> fetchData({bool hasOrders = true}) async {
    try {
      await Future<void>.delayed(Duration.zero);

      emit(const FetchingDataState());

      final result = await DeliveryService.deliveryList(
        pagination: const Pagination(limit: 1000),
        hasOrders: hasOrders,
      );

      if (result is DeliveryList) {
        deliveryList = result;

        emit(const FetchedDataState());
      } else {
        throw result.toString();
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
