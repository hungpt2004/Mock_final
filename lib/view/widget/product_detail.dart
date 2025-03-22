import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_final/bloc/cart/cart_state.dart';
import 'package:mock_final/bloc/favourite/favorite_bloc.dart';
import 'package:mock_final/theme/action/push_page.dart';
import 'package:mock_final/theme/action/scaffold_msg.dart';
import 'package:mock_final/theme/style/style_button.dart';
import 'package:mock_final/theme/style/style_color.dart';
import 'package:mock_final/theme/style/style_space.dart';
import 'package:mock_final/view/home_screen.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../model/product.dart';
import '../../theme/style/style_appbar.dart';
import '../../theme/style/style_text.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isLoadButton1 = false;
  bool isLoadButton2 = false;
  bool isLoadButton3 = false;

  _startLoad(int number) async {
    setState(() {
      if (number == 1) {
        isLoadButton1 = true;
      }
      if (number == 2) {
        isLoadButton2 = true;
      }
      if (number == 3) {
        isLoadButton3 = true;
      }
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      if (number == 1) {
        isLoadButton1 = false;
      }
      if (number == 2) {
        isLoadButton2 = false;
      }
      if (number == 3) {
        isLoadButton3 = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Product product = widget.product;


    return Scaffold(
      appBar: StyleAppBar.Widget("Details Products"),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if(state is CartLoadFailure || state is CartLoadInProgress){
          return Center(child: Text("No data"),);
        } else {
          return ListView(
            children: [
              StyleSpace.space(20, 0),
              Expanded(
                child: SizedBox(
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(product.image),
                  ),
                ),
              ),
              StyleSpace.space(20, 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    decoration: BoxDecoration(
                        color: StyleColor.lightBlueColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Text(
                        product.name,
                        style:
                        StyleText.styleAirbnb(25, FontWeight.w600, Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              StyleSpace.space(20, 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "BEST SELLER",
                    style: StyleText.styleAirbnb(
                        20, FontWeight.w400, StyleColor.lightBlueColor),
                  ),
                  StyleSpace.space(0, 10),
                  SizedBox(
                    width: 160,
                    height: 80,
                    child: Stack(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      children: [
                        Positioned(
                          left: 5, // Vị trí từ bên trái
                          top: 10, // Vị trí từ trên xuống
                          child: Container(
                            width: 40, // Kích thước chiều rộng
                            height: 50, // Kích thước chiều cao
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("assets/images/user1.jpg"))),
                          ),
                        ),
                        Positioned(
                          left: 25, // Vị trí từ bên trái
                          top: 10, // Vị trí từ trên xuống
                          child: Container(
                            width: 40, // Kích thước chiều rộng
                            height: 50, // Kích thước chiều cao
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("assets/images/user2.jpg"))),
                          ),
                        ),
                        Positioned(
                          left: 45, // Vị trí từ bên trái
                          top: 10, // Vị trí từ trên xuống
                          child: Container(
                            width: 40, // Kích thước chiều rộng
                            height: 50, // Kích thước chiều cao
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("assets/images/user3.jpg"))),
                          ),
                        ),
                        Positioned(
                          left: 70, // Vị trí từ bên trái
                          top: 10, // Vị trí từ trên xuống
                          child: Container(
                            width: 40, // Kích thước chiều rộng
                            height: 50, // Kích thước chiều cao
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("assets/images/user4.jpg"))),
                          ),
                        ),
                        Positioned(
                          left: 110, // Vị trí từ bên trái
                          top: 10, // Vị trí từ trên xuống
                          child: SizedBox(
                            width: 40, // Kích thước chiều rộng
                            height: 50, // Kích thước chiều cao
                            child: Center(
                              child: Text(
                                "+28",
                                style: StyleText.styleAirbnb(
                                    14, FontWeight.w400, Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              StyleSpace.space(10, 0),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Divider(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
              StyleSpace.space(15, 0),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Information Device",
                        style: StyleText.styleAirbnb(
                            18, FontWeight.w600, Colors.black)),
                    StyleSpace.space(5, 0),
                    Text("Manufactor: ${product.manufacturer}",
                        style: StyleText.styleAirbnb(
                            14, FontWeight.w400, Colors.black)),
                    StyleSpace.space(5, 0),
                    Text("Category: ${product.category}",
                        style: StyleText.styleAirbnb(
                            14, FontWeight.w400, Colors.black)),
                    StyleSpace.space(5, 0),
                    Text("Condition: ${product.condition}",
                        style: StyleText.styleAirbnb(
                            14, FontWeight.w400, Colors.black)),
                    StyleSpace.space(5, 0),
                    Text("Quantity: ${product.quantity} products",
                        style: StyleText.styleAirbnb(
                            14, FontWeight.w400, Colors.black)),
                    StyleSpace.space(5, 0),
                    Text("Price: ${product.price}\$",
                        style: StyleText.styleAirbnb(
                            14, FontWeight.w500, Colors.black)),
                  ],
                ),
              ),
              StyleSpace.space(15, 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: StyleButton.ButtonStyleLoading(isLoadButton1),
                      onPressed: () async {
                        await _startLoad(1);
                        StylePush.navigatorPush(context, const BottomNavbar());
                      },
                      child: isLoadButton1 ? StyleButton.loading() : Text("Back home",style: StyleText.styleAirbnb(
                          14, FontWeight.w400, Colors.black))),
                  ElevatedButton(
                      style: StyleButton.ButtonStyleLoading(isLoadButton2),
                      onPressed: () async {
                        await _startLoad(2);
                        FavoriteBloc.addFavorite(context, product);
                      },
                      child: isLoadButton2 ? StyleButton.loading() : Text("+ Favorite",style: StyleText.styleAirbnb(
                          14, FontWeight.w400, Colors.black))),
                  ElevatedButton(
                      style: StyleButton.ButtonStyleLoading(isLoadButton3),
                      onPressed: () async {
                        await _startLoad(3);
                        CartBloc.addToCart(context, product);
                      },
                      child: isLoadButton3 ? StyleButton.loading() : Text("Add to Cart",style: StyleText.styleAirbnb(
                          14, FontWeight.w400, Colors.black))),
                ],
              )
            ],
          );
        }
      })
    );
  }
}
