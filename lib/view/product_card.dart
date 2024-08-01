import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import '../cart/cart_bloc.dart';
import '../cart/cart_event.dart';
import '../model/product.dart';
import '../view/product_detail.dart';
import '../view/shopping_cart.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late Future<List<Product>> products;
  List<Product> allProducts = [];
  int currentPage = 1;
  final int pageSize = 4;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchInitialProducts();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fetch data from API with paging
  Future<List<Product>> _fetchProducts(
      {required int page, required int limit}) async {
    final url = Uri.parse(
        'http://10.0.2.2:8080/api/v2/products?page=$page&limit=$limit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return _parseProduct(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Convert JSON data from API to product
  static List<Product> _parseProduct(String response) {
    final jsonObject = jsonDecode(response);
    final List<dynamic> jsonResponse = jsonObject['content'];
    return jsonResponse.map<Product>((json) => Product.fromJson(json)).toList();
  }

  void _fetchInitialProducts() {
    setState(() {
      products = _fetchProducts(page: currentPage, limit: pageSize);
      products.then((newProducts) {
        setState(() {
          allProducts.clear();
          allProducts.addAll(newProducts);
        });
      });
    });
  }

  // Get more products until scroll full page
  void _fetchMoreProducts() {
    setState(() {
      isLoading = true;
    });

    _fetchProducts(page: currentPage + 1, limit: pageSize).then((newProduct) {
      setState(() {
        if (newProduct.isNotEmpty) {
          currentPage++;
          allProducts.addAll(newProduct);
        }
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
    });
  }

  // Listen view event
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent && !isLoading) {
      _fetchMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'Products',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              'All available products in our store',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
                if (snapshot.hasData || allProducts.isNotEmpty) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: allProducts.length,
                      itemBuilder: (context, index) {
                        final product = allProducts[index];
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                    ),
                                    child: Image.network(
                                      product.image,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '\$${product.price}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${product.quantity} units in stock',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetail(productId: product.id),
                                                      ),
                                                    );
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Row(
                                                    children: [
                                                      Icon(Icons.info_rounded, color: Colors.white),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'View Details',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    context.read<CartBloc>().add(AddToCart(product: product));
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Add new product to cart successfully!'),
                                                        duration: Duration(seconds: 2),
                                                      ),
                                                    );
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Row(
                                                    children: [
                                                      Icon(Icons.shopping_cart, color: Colors.white),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'Order Now',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Center(
                  child: LoadingBouncingLine.circle(
                    backgroundColor: Colors.blue,
                    size: 60.0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: 0,
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShoppingCart()));
          }
          if (index == 2) {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
          }
        },
      ),
    );
  }
}
