import 'dart:convert';

import 'dart:developer';

import '../usage_criteria.dart';

class OrderCustomer implements UsageCriteria {
  const OrderCustomer({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  final int id;
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String image;

  OrderCustomer copyWith({
    int id,
    int userId,
    String name,
    String email,
    String phone,
    String image,
  }) {
    try {
      return OrderCustomer(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
      );
    } catch (e) {
      log('Exception in OrderCustomer.copyWith : $e');
      return const OrderCustomer();
    }
  }

  factory OrderCustomer.fromJson(String str) {
    if (str == null || str.isEmpty) return const OrderCustomer();

    try {
      return OrderCustomer.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in OrderCustomer.fromJson : $e');
      return const OrderCustomer();
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderCustomer.fromMap(Map<String, dynamic> json, {int orderId}) {
    try {
      if (json == null || json.isEmpty) return const OrderCustomer();
      return OrderCustomer(
        id: json["id"] as int,
        userId: json["user_id"] as int,
        name: json["name"] as String,
        email: json["email"] as String,
        phone: json["phone"] as String,
        image: json["image"] as String,
      );
    } catch (e) {
      log('Exception in OrderCustomer.fromMap : $e');
      return const OrderCustomer();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
      };
    } catch (e) {
      log('Exception in OrderCustomer.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in OrderCustomerMan.unusable : $e');

      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null;
    } catch (e) {
      log('Exception in OrderCustomerMan.unusable : $e');

      return true;
    }
  }
}
