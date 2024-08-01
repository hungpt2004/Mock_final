class OrderDetail {
  final int productId;
  final int quantity;
  final int price;

  OrderDetail({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      productId: json['productId'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
