import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_final/theme/action/push_page.dart';
import 'package:mock_final/theme/style/style_color.dart';
import 'package:mock_final/view/home_screen.dart';
import 'package:mock_final/view/widget/product_card.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_event.dart';
import '../../bloc/cart/cart_state.dart';
import '../../theme/style/style_appbar.dart';
import '../../theme/style/style_space.dart';
import '../../theme/style/style_text.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('ALO');
    return Scaffold(
      appBar: StyleAppBar.Widget("Cart Products"),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadFailure ||
              state.cartProducts.isEmpty ||
              state is CartLoadInProgress) {
            return const Scaffold(
              body: Center(
                child: Text("No have any product in cart! Please add"),
              ),
            );
          } else {
            return Scaffold(
              body: SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                        itemCount: state.cartProducts.length,
                        itemBuilder: (context, index) {
                          final cartItemIndex = state.cartProducts[index];
                          print(cartItemIndex.product.quantity);
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: SingleChildScrollView(
                              child: Card(
                                elevation: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Hình ảnh sản phẩm
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            cartItemIndex.product.image,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                  cartItemIndex.product.name,
                                                  style: StyleText.styleAirbnb(
                                                      14,
                                                      FontWeight.w400,
                                                      Colors.black)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                  "${cartItemIndex.product.description} - ${cartItemIndex.product.condition}",
                                                  style: StyleText.styleAirbnb(
                                                      14,
                                                      FontWeight.w400,
                                                      Colors.black)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                '\$${cartItemIndex.product.price.toStringAsFixed(2)}',
                                                style: StyleText.styleAirbnb(
                                                    14,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      CartBloc.incrementQuantity(
                                                          context,
                                                          cartItemIndex.product,
                                                          cartItemIndex);
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 18,
                                                      color: Colors.black,
                                                    )),
                                                Text(
                                                  "${cartItemIndex.quantity}",
                                                  style: StyleText.styleAirbnb(
                                                      14,
                                                      FontWeight.w400,
                                                      Colors.black),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      if (cartItemIndex.quantity >
                                                          1) {
                                                        CartBloc
                                                            .decrementQuantity(
                                                                context,
                                                                cartItemIndex
                                                                    .product,
                                                                cartItemIndex);
                                                      } else {
                                                        CartBloc.removeFromCart(
                                                            context,
                                                            cartItemIndex
                                                                .product);
                                                      }
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                      color: Colors.black,
                                                    )),
                                                StyleSpace.space(0,30),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            TextButton(onPressed: (){
                                              CartBloc.removeFromCart(context, cartItemIndex.product);
                                            }, child: Image.asset("assets/images/bin.png",width: 20,height: 30,)),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      decoration: BoxDecoration(
                          color: StyleColor.darkBlueColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Total Cart",
                            style: StyleText.styleAirbnb(
                                20, FontWeight.w500, Colors.white),
                          ),
                          Text("${state.totalPrice}\$",
                              style: StyleText.styleAirbnb(
                                  20, FontWeight.w500, Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
//
// Container(
// width: MediaQuery.of(context).size.width * 0.9,
// height: 50,
// decoration: BoxDecoration(
// color: StyleColor.darkBlueColor,
// borderRadius: BorderRadius.circular(20)
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Text("Total Cart",style: StyleText.styleAirbnb(20, FontWeight.w500, Colors.white),),
// Text("${state.totalPrice}\$",style: StyleText.styleAirbnb(20, FontWeight.w500, Colors.white))
// ],
// ),
// )