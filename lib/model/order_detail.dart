class OrderDetail {
  final int productId;
  final int quantity;
  final int unitPrice;

  OrderDetail({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  });

  Map<String,dynamic> toJson(){
    return {
      "productId":productId,
      "quantity":quantity,
      "unitPrice":unitPrice
    };
  }

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      productId: json['productId'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
    );
  }

  @override
  String toString() {
    return 'OrderDetail{productId: $productId, quantity: $quantity, unitPrice: $unitPrice}';
  }
}
