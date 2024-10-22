class Product {
  final int id;
  final String name;
  final int price;
  int quantity;
  final String description;
  final String manufacturer;
  final String category;
  final String condition;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.manufacturer,
    required this.category,
    required this.condition,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      description: json['description'],
      manufacturer: json['manufacturer'],
      category: json['category'],
      condition: json['condition'],
      image: json['image'],
    );
  }
}
