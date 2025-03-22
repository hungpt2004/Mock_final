import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mock_final/theme/action/push_page.dart';
import 'package:mock_final/theme/style/style_appbar.dart';
import 'package:mock_final/theme/style/style_color.dart';
import 'package:mock_final/theme/style/style_text.dart';
import 'package:mock_final/view/widget/product_detail.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../model/product.dart';
import '../../service/api.dart';
import '../../theme/style/style_button.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late Future<List<Product>> products;
  int currentPage = 0;
  int? loadingDetailsIndex; // Chỉ số sản phẩm đang load cho "Details"
  int? loadingCartIndex; // Chỉ số sản phẩm đang load cho "Add Cart"
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    products = Api().fetchProducts();
  }

  Future<void> _startLoadDetails(int index) async {
    setState(() {
      loadingDetailsIndex =
          index; // Chỉ set cho nút "Details" của sản phẩm được nhấn
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      loadingDetailsIndex = null; // Reset sau khi load xong
    });
  }

  Future<void> _startLoadCart(int index) async {
    setState(() {
      loadingCartIndex =
          index; // Chỉ set cho nút "Add Cart" của sản phẩm được nhấn
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      loadingCartIndex = null; // Reset sau khi load xong
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleAppBar.Widget("Products"),
      body: _buildProductGrid(),
    );
  }

  Widget _buildProductGrid() {
    return FutureBuilder<List<Product>>(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final productList = snapshot.data!;
          return Column(
            children: [
              Expanded(
                  flex: 1,
                  child: CarouselSlider.builder(
                      itemCount: productList.length,
                      itemBuilder: (context, index, realIndex){
                        final items = productList[index];
                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                  child: SizedBox(
                                    width: 100,
                                      child: ClipRRect(
                                        child: Image.network(items.image),
                                      ),
                                  )
                              ),
                              Expanded(
                                flex: 1,
                                  child: Center(
                                    child: Text(items.name,style: StyleText.styleAirbnb(20, FontWeight.w400, StyleColor.darkBlueColor),),
                                  )
                              )
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                          autoPlay: true,
                          autoPlayAnimationDuration: const Duration(seconds: 2),
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.5,
                          enlargeCenterPage: true,
                          autoPlayCurve: Curves.fastOutSlowIn
                      )
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AnimatedSmoothIndicator(
                  duration: const Duration(milliseconds: 800),
                  activeIndex: activeIndex,
                  count: 4,
                  effect: const WormEffect(
                    activeDotColor: StyleColor.darkBlueColor, dotHeight: 5, dotWidth: 15, ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    itemCount: productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final productIndex = productList[index];
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    productIndex.image,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "BEST SELLER",
                                  style: StyleText.styleAirbnb(
                                      16,
                                      FontWeight.w400,
                                      StyleColor.lightBlueColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  productIndex.name,
                                  style: StyleText.styleAirbnb(
                                      14, FontWeight.w400, Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '\$${productIndex.price.toStringAsFixed(2)}',
                                  style: StyleText.styleAirbnb(
                                      14, FontWeight.w500, Colors.black),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await _startLoadDetails(index);
                                        StylePush.navigatorPush(
                                            context,
                                            ProductDetail(
                                                product: productIndex));
                                      },
                                      style: StyleButton.ButtonStyleLoading(
                                          loadingDetailsIndex == index),
                                      child: loadingDetailsIndex == index
                                          ? StyleButton.loading()
                                          : const Icon(
                                              Icons.menu_outlined,
                                              color: StyleColor.darkBlueColor,
                                              size: 15,
                                            )),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await _startLoadCart(index);
                                        CartBloc.addToCart(
                                            context, productIndex);
                                      },
                                      style: StyleButton.ButtonStyleLoading(
                                          loadingCartIndex == index),
                                      child: loadingCartIndex == index
                                          ? StyleButton.loading()
                                          : SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Image.asset(
                                                  "assets/images/cart.png"),
                                            )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return Center(
          child: LoadingBouncingLine.circle(
            backgroundColor: Colors.blue,
            size: 60.0,
          ),
        );
      },
    );
  }
}
