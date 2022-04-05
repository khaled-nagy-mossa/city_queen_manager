import 'dart:convert';
import 'dart:developer';

import '../../../model/order/order.dart';

import 'glance.dart';
import 'order_label.dart';

class HomeViewModel {
  const HomeViewModel({
    this.income,
    this.orders,
    this.orderLabels,
    this.glance,
    this.newOrders,
  });

  final String income;
  final String orders;
  final List<OrderLabel> orderLabels;
  final Glance glance;
  final List<Order> newOrders;

  HomeViewModel copyWith({
    String income,
    String orders,
    List<OrderLabel> orderLabels,
    Glance glance,
    List<Order> newOrders,
  }) {
    try {
      return HomeViewModel(
        income: income ?? this.income,
        orders: orders ?? this.orders,
        orderLabels: orderLabels ?? this.orderLabels,
        glance: glance ?? this.glance,
        newOrders: newOrders ?? this.newOrders,
      );
    } catch (e) {
      log('Exception in HomeViewModel.copyWith : $e');
      return this;
    }
  }

  factory HomeViewModel.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) {
        return const HomeViewModel();
      }
      return HomeViewModel.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in HomeViewModel.fromJson : $e');
      return const HomeViewModel();
    }
  }

  String toJson() => json.encode(toMap());

  factory HomeViewModel.fromMap(Map<String, dynamic> json) {
    try {
      return HomeViewModel(
        income: json['income'] as String,
        orders: json['orders'] as String,
        orderLabels: (json['counts'] == null)
            ? []
            : List<OrderLabel>.from(
                (json['counts'] as List).map<OrderLabel>(
                  (dynamic x) => OrderLabel.fromMap(x as Map<String, dynamic>),
                ),
              ),
        glance: (json['glance'] == null)
            ? const Glance()
            : Glance.fromMap(json['glance'] as Map<String, dynamic>),
        newOrders: List<Order>.generate(
          (json['new_orders'] as List).length,
          (index) => Order.fromMap(
              (json['new_orders'] as List)[index] as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      log('Exception in HomeViewModel.fromMap : $e');
      return const HomeViewModel();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'income': income,
        'orders': orders,
        'counts': orderLabels == null
            ? <dynamic>[]
            : List<dynamic>.from(
                orderLabels
                    .map<dynamic>((x) => x?.toMap() ?? <String, dynamic>{}),
              ),
        'glance': glance?.toMap() ?? <String, dynamic>{},
        'new_orders': newOrders == null
            ? <dynamic>[]
            : List<dynamic>.from(
                newOrders
                    .map<dynamic>((x) => x?.toMap() ?? <String, dynamic>{}),
              ),
      };
    } catch (e) {
      log('Exception in HomeViewModel.toMap : $e');
      return <String, dynamic>{};
    }
  }
}
