import 'order_detail.dart';

class Order {
  // final DateTime orderDate;
  final double total; // Changed to int
  final int paymentMethod;
  final int orderStatus;
  final List<OrderDetail> details; // List of OrderDetail objects

  Order({
    // required this.orderDate,
    required this.total, // Updated constructor
    this.paymentMethod = 2,
    this.orderStatus = 1,
    required this.details, // Updated constructor
  });

  Map<String, dynamic> toJson(){
    return {
      // "orderDate": orderDate.toIso8601String(),
      "total":total,
      "paymentMethod":paymentMethod,
      "orderStatus":orderStatus,
      "details": details.map((item) => item.toJson()).toList()
    };
  }


  factory Order.fromJson(Map<String, dynamic> json) {
    var detailsJson = json['details'] as List; // Extract details from JSON
    return Order(
      // orderDate: json['orderDate'],
      total: json['total'],
      paymentMethod: json['paymentMethod'],
      orderStatus: json['orderStatus'],
      details: detailsJson.map((detail) => OrderDetail.fromJson(detail)).toList(), // Convert details list
    );
  }

  @override
  String toString() {
    return 'Order{total: $total, paymentMethod: $paymentMethod, orderStatus: $orderStatus, details: ${details.map((items)=>items.toString())}';
  }
}
