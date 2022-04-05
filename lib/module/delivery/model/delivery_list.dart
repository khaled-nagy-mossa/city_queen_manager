import 'dart:convert';
import 'dart:developer';

import 'package:branch_manager/module/delivery/model/delivery.dart';

class DeliveryList {
  const DeliveryList({
    this.count,
    this.drivers,
  });

  final int count;
  final List<Delivery> drivers;

  DeliveryList copyWith({
    int count,
    List<Delivery> drivers,
  }) {
    return DeliveryList(
      count: count ?? this.count,
      drivers: drivers ?? this.drivers,
    );
  }

  factory DeliveryList.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) {
        return const DeliveryList();
      }
      return DeliveryList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in DeliveryList.fromJson : $e');
      return const DeliveryList();
    }
  }

  String toJson() => json.encode(toMap());

  factory DeliveryList.fromMap(Map<String, dynamic> json) {
    try {
      return DeliveryList(
        count: json["count"] as int,
        drivers: json["drivers"] == null
            ? null
            : List<Delivery>.from(
                (json["drivers"] as List).map(
                  (x) => Delivery.fromMap(x as Map<String, dynamic>),
                ),
              ),
      );
    } catch (e) {
      log('Exception in DeliveryList.fromMap : $e');
      return const DeliveryList();
    }
  }

  Map<String, dynamic> toMap() => {
        "count": count,
        "drivers": List<dynamic>.from(drivers.map((x) => x.toMap())),
      };
}
