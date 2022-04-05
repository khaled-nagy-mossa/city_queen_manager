import 'dart:convert';

class OrdersByMonth {
  OrdersByMonth({
    this.ordersByMonth,
  });

  final List<OrdersByMonthElement> ordersByMonth;

  OrdersByMonth copyWith({
    List<OrdersByMonthElement> ordersByMonth,
  }) {
    return OrdersByMonth(
      ordersByMonth: ordersByMonth ?? this.ordersByMonth,
    );
  }

  factory OrdersByMonth.fromJson(String str) {
    return OrdersByMonth.fromMap(
      json.decode(str) as Map<String, dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersByMonth.fromMap(Map<String, dynamic> json) {
    return OrdersByMonth(
      ordersByMonth: List<OrdersByMonthElement>.from(
        (json["orders_by_month"] as List).map(
          (x) => OrdersByMonthElement.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "orders_by_month":
            List<dynamic>.from(ordersByMonth.map((x) => x.toMap())),
      };
}

class OrdersByMonthElement {
  OrdersByMonthElement({
    this.month,
    this.label,
    this.ordersCount,
  });

  final String month;
  final String label;
  final int ordersCount;

  OrdersByMonthElement copyWith({
    String month,
    String label,
    int ordersCount,
  }) {
    return OrdersByMonthElement(
      month: month ?? this.month,
      label: label ?? this.label,
      ordersCount: ordersCount ?? this.ordersCount,
    );
  }

  factory OrdersByMonthElement.fromJson(String str) {
    return OrdersByMonthElement.fromMap(
      json.decode(str) as Map<String, dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersByMonthElement.fromMap(Map<String, dynamic> json) {
    return OrdersByMonthElement(
      month: json["month"] as String,
      label: json["label"] as String,
      ordersCount: json["orders_count"] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "month": month,
      "label": label,
      "orders_count": ordersCount,
    };
  }
}
