import 'order_detail.dart';

class Order {
  final int id;
  final String orderDate;
  final int total; // Changed to int
  final String paymentMethod;
  final String orderStatus;
  final List<OrderDetail> details; // List of OrderDetail objects

  Order({
    required this.id,
    required this.orderDate,
    required this.total, // Updated constructor
    required this.paymentMethod,
    required this.orderStatus,
    required this.details, // Updated constructor
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var detailsJson = json['details'] as List; // Extract details from JSON

    return Order(
      id: json['id'],
      orderDate: json['orderDate'],
      total: json['total'],
      paymentMethod: json['paymentMethod'],
      orderStatus: json['orderStatus'],
      details: detailsJson.map((detail) => OrderDetail.fromJson(detail)).toList(), // Convert details list
    );
  }
}
