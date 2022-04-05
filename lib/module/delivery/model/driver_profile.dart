import 'dart:convert';

import 'package:branch_manager/module/delivery/model/order_label.dart';

import 'delivery.dart';
import 'orders_by_month.dart';

class DriverProfile {
  DriverProfile({
    this.profileData,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.totalCollected,
    this.totalEarning,
    this.counts,
    this.ordersByMonth,
  });

  final Delivery profileData;
  final String name;
  final String phone;
  final String email;
  final String image;
  final String totalCollected;
  final String totalEarning;
  final List<OrderLabel> counts;
  final OrdersByMonth ordersByMonth;

  DriverProfile copyWith(
          {Delivery profileData,
          String name,
          String phone,
          String email,
          String image,
          String totalCollected,
          String totalEarning,
          List<OrderLabel> counts,
          OrdersByMonth ordersByMonth}) =>
      DriverProfile(
        profileData: profileData ?? this.profileData,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        image: image ?? this.image,
        totalCollected: totalCollected ?? this.totalCollected,
        totalEarning: totalEarning ?? this.totalEarning,
        counts: counts ?? this.counts,
        ordersByMonth: ordersByMonth ?? this.ordersByMonth,
      );

  factory DriverProfile.fromJson(String str) {
    return DriverProfile.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory DriverProfile.fromMap(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>;

    return DriverProfile(
      profileData:
          Delivery.fromMap(data.first["profile_data"] as Map<String, dynamic>),
      name: data.first["name"] as String,
      phone: data.first["phone"] as String,
      email: data.first["email"] as String,
      image: data.first["image"] as String,
      totalCollected: data.first["total_collected"] as String,
      totalEarning: data.first["total_earning"] as String,
      counts: List<OrderLabel>.from(
        (data.first["counts"] as List)
            .map((x) => OrderLabel.fromMap(x as Map<String, dynamic>)),
      ),
      ordersByMonth: OrdersByMonth.fromMap(
        data.last as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "profile_data": profileData.toMap(),
        "name": name,
        "phone": phone,
        "email": email,
        "image": image,
        "total_collected": totalCollected,
        "total_earning": totalEarning,
        "counts": List<dynamic>.from(counts.map((x) => x.toMap())),
      };
}
