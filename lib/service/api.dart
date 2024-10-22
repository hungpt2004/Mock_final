import 'dart:convert';
import 'package:http/http.dart' as http;
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

  Future<Product> getProductById(int id) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v2/products/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> productJson = jsonDecode(response.body);
      return Product.fromJson(productJson);
    } else {
      throw Exception('Failed to load product with id: $id');
    }
  }

}

