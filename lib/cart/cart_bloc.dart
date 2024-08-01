import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../cart/cart_event.dart';
import '../cart/cart_state.dart';
import '../model/cart.dart';
import 'package:http/http.dart' as http;

import '../model/order.dart';
import '../model/order_detail.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartLoadInProgress(cartItems: [])) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCartById>(_onRemoveFromCartById);
    on<ClearCart>(_onClearCart);
    on<CheckoutCart>(_onCheckoutCart);
  }

  //Add to cart
  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final List<CartModel> updatedCartItems = List.from(state.cartItems);
    final existingItemIndex = updatedCartItems
        .indexWhere((item) => item.product.id == event.product.id);

    if (existingItemIndex >= 0) {
      final existingItem = updatedCartItems[existingItemIndex];
      updatedCartItems[existingItemIndex] = CartModel(
        product: existingItem.product,
        quantity: existingItem.quantity + 1,
      );
    } else {
      updatedCartItems.add(CartModel(product: event.product, quantity: 1));
    }
    emit(CartUpdated(cartItems: updatedCartItems));
  }

  //Remove by ID
  void _onRemoveFromCartById(
      RemoveFromCartById event, Emitter<CartState> emit) {
    final List<CartModel> updatedCartItems = List.from(state.cartItems);
    updatedCartItems.removeWhere((item) => item.product.id == event.productId);
    emit(CartUpdated(cartItems: updatedCartItems));
  }

  //Clear All
  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartUpdated(cartItems: []));
  }

  // Checkout
  void _onCheckoutCart(CheckoutCart event, Emitter<CartState> emit) async {
    final List<CartModel> cartItems = state.cartItems;

    //Dung fold de duyet qua mang va tinh tong
    final int total = cartItems.fold(0, (sum, item) => sum + item.totalPrice);

    // Tạo danh sách các đối tượng OrderDetail từ cartItems
    final orderDetails = cartItems
        .map((item) => OrderDetail(
              productId: item.product.id,
              quantity: item.quantity,
              price: item.product.price,
            ))
        .toList();

    // Tạo đối tượng Order từ danh sách orderDetails
    final order = Order(
      id: 0,
      orderDate: DateTime.now().toIso8601String(),
      total: total,
      paymentMethod: "CASH",
      orderStatus: "PROCESSING",
      details: orderDetails,
    );

    // Chuyển đối tượng Order thành JSON
    final orderData = jsonEncode({
      "total": order.total,
      "paymentMethod": 2, // Thay đổi thành phương thức thanh toán thực tế
      "orderStatus": 1, // Trạng thái đơn hàng
      "details": order.details
          .map((detail) => {
                "productId": detail.productId,
                "quantity": detail.quantity,
                "price": detail.price
              })
          .toList(),
    });

    //In để check
    print('Order Data: $orderData');
    const String TOKEN =
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsInJvbGUiOiJ"
        "BRE1JTiIsImlhdCI6MTcyMTkxMjM2OSwiZXhwIjoxNzIxOTE0MTY5fQ"
        ".Vb_T-HhyPMsu0HDsR_phZvUdgzjwCsEgNWiKJ-Jl0F8";
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/v2/orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer $TOKEN', // Thay YOUR_ACCESS_TOKEN bằng token thực tế
        },
        body: orderData,
      );

      if (response.statusCode == 201) {
        print('Response body: ${response.body}');
        emit(const CartUpdated(cartItems: []));
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            content: Text('Checkout successfully!'),
          ),
        );
      } else {
        emit(CartLoadFailure(cartItems: cartItems));
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            content: Text('Checkout failed!'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      emit(CartLoadFailure(cartItems: cartItems));
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          content: Text('Failed to place order'),
        ),
      );
    }
  }
}
