import 'dart:convert';

import 'package:branch_manager/common/config/api.dart';
import 'package:branch_manager/model/pagination.dart';
import 'package:branch_manager/module/delivery/config/network.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';
import 'package:flutter/material.dart';

abstract class DeliveryRepo {
  const DeliveryRepo();

  static Future<SuperResponseModel> deliveryList({
    Pagination pagination,
    bool hasOrders = true,
  }) async {
    String more;
    if (hasOrders == true) {
      more = '&has_orders=YES';
    } else if (hasOrders == false) {
      more = '&has_orders=NO';
    } else {
      more = '';
    }

    String url = DeliveryApis.driversList;
    if (pagination != null) url += pagination.parse() + more;

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }

  static Future<SuperResponseModel> updateOrderDriver({
    @required int orderId,
    @required int driverId,
  }) async {
    assert(orderId != null, 'order id must not be null');
    assert(driverId != null, 'driver id must not be null');

    final Map<String, dynamic> bodyData = {
      "order_id": orderId,
      "status": "in_delivery",
      "driver_id": driverId,
    };

    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(DeliveryApis.updateOrderDriver),
        header: await API.header(),
        body: json.encoder.convert(bodyData)));
  }

  static Future<SuperResponseModel> driverProfile({
    @required int driverId,
    @required String startMonth,
    @required String endMonth,
  }) async {
    assert(driverId != null);
    assert(startMonth != null);
    assert(endMonth != null);

    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(DeliveryApis.driverProfile),
        header: await API.header(),
        body: json.encoder.convert({
          "driver_id": driverId,
          "start_month": startMonth,
          "end_month": endMonth,
        }),
      ),
    );
  }

  static Future<SuperResponseModel> driverOrderList({
    @required int driverId,
    Pagination pagination,
    String status,
  }) async {
    assert(driverId != null, 'driver id must not be null');

    String url = DeliveryApis.driverOrderList;
    if (pagination != null) url += pagination.parse();

    final body = <String, dynamic>{"user_id": driverId};
    if (status != null) {
      body["status"] = status;
    }

    return HttpHelper.simpleRequest(HttpHelper.post(
      HttpHelper.url(url),
      header: await API.header(),
      body: json.encoder.convert(body),
    ));
  }
}
