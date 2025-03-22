import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/order.dart';
import '../model/product.dart';

class Api {

  final client = http.Client();

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse(
        'http://10.0.2.2:8080/api/v2/products');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final Map<String,dynamic> json = jsonDecode(response.body);

      final List<dynamic> jsonData = json['content'];

      return jsonData.map((items) => Product.fromJson(items)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Order>> fetchOrder() async {
    final url = Uri.parse(
        'http://10.0.2.2:8080/api/v2/orders');
    final response = await client.get(url);

    if (response.statusCode == 200) {

      final List<dynamic> json = jsonDecode(response.body);

      return json.map((items) => Order.fromJson(items)).toList();

    } else {
      throw Exception('Failed to load orders');
    }
  }


  Future<Product> getProductById(int id) async {
    final response = await client.get(Uri.parse('http://10.0.2.2:8080/api/v2/products/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> productJson = jsonDecode(response.body);
      return Product.fromJson(productJson);
    } else {
      throw Exception('Failed to load product with id: $id');
    }
  }


  Future<Order> addNewOrder(Order order) async {
    final response = await client.post(Uri.parse("http://10.0.2.2:8080/api/v2/orders"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTcyOTY'
            'zODE4NywiZXhwIjoxNzI5NjM5OTg3fQ._iU6aUWYHm70Ojhd0rKveSIIMXkkgq8HXMBe7tbbXog'
      },
      body: jsonEncode({
        'total': order.total,
        'paymentMethod': order.paymentMethod, // Thêm paymentMethod nếu cần
        'orderStatus': order.orderStatus, // Thêm orderStatus nếu cần
        'details': order.details.map((detail) => {
          'productId': detail.productId,
          'quantity': detail.quantity,
          'unitPrice': detail.unitPrice,
        }).toList(),
      }),);
    print(jsonEncode(order.toJson()));
    print(order.toString());
    print(response.statusCode);
    if(response.statusCode == 201 || response.statusCode == 200){
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      print(jsonDecode(response.body));
      return Order.fromJson(jsonData);
    } else {
      print(jsonDecode(response.body));
      print('Response body: ${response.body}');
      throw Exception("Failed to add order");
    }
  }




}

