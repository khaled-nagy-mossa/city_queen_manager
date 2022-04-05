import 'package:branch_manager/model/order/order.dart';
import 'package:branch_manager/model/order/order_list.dart';
import 'package:branch_manager/model/pagination.dart';
import 'package:branch_manager/module/delivery/model/delivery_list.dart';
import 'package:branch_manager/module/delivery/model/driver_profile.dart';
import 'package:branch_manager/module/delivery/repo/repo.dart';
import 'package:flutter/material.dart';

abstract class DeliveryService {
  const DeliveryService();

  static Future deliveryList({
    Pagination pagination,
    bool hasOrders = true,
  }) async {
    try {
      final result = await DeliveryRepo.deliveryList(
        pagination: pagination,
        hasOrders: hasOrders,
      );

      if (result.hasError) throw result.msg;

      return DeliveryList.fromMap(
        result.json['result'] as Map<String, dynamic>,
      );
    } catch (e) {
      return e.toString();
    }
  }

  static Future updateOrderDriver({
    @required int orderId,
    @required int driverId,
  }) async {
    assert(orderId != null);
    assert(driverId != null);

    try {
      final res = await DeliveryRepo.updateOrderDriver(
        driverId: driverId,
        orderId: orderId,
      );
      res.printData();
      if (res.hasError) return res.msg;

      return Order.fromMap(res.json['result']['data'] as Map<String, dynamic>);
    } catch (e) {
      return e.toString();
    }
  }

  static Future driverProfile({
    @required int driverId,
    @required String startMonth,
    @required String endMonth,
  }) async {
    assert(driverId != null);
    assert(startMonth != null);
    assert(endMonth != null);

    try {
      final res = await DeliveryRepo.driverProfile(
        driverId: driverId,
        startMonth: startMonth,
        endMonth: endMonth,
      );

      if (res.hasError) return res.msg;

      return DriverProfile.fromMap(
        res.json['result'] as Map<String, dynamic>,
      );
    } catch (e) {
      return e.toString();
    }
  }

  static Future driverOrderList({
    @required int driverId,
    Pagination pagination,
    String status,
  }) async {
    assert(driverId != null, 'driver id must not be null');
    try {
      final res = await DeliveryRepo.driverOrderList(
        driverId: driverId,
        pagination: pagination,
        status: status,
      );

      if (res.hasError) {
        return res.msg;
      }
      return OrderList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      return e.toString();
    }
  }
}
