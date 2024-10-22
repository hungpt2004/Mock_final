
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_final/model/cart.dart';
import '../../model/product.dart';
import '../cart/cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  

  CartBloc() : super(CartState(cartProducts: [], totalPrice: 0)) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncrementQuantity>(_onIncrementQuantity);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final List<CartItem> updatedCartItems = List.from(state.cartProducts);
    final existingItemIndex = updatedCartItems
        .indexWhere((item) => item.product.id == event.product.id);

    if (existingItemIndex >= 0) {
      final existingItem = updatedCartItems[existingItemIndex];
      updatedCartItems[existingItemIndex] = CartItem(
        product: existingItem.product,
        quantity: existingItem.quantity + 1,
      );
    } else {
      updatedCartItems.add(CartItem(product: event.product, quantity: 1));
    }
    emit(CartUpdated(cartProducts: updatedCartItems, totalPrice: _calculateTotalPrice(updatedCartItems)));
  }

  //Remove by ID
  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final List<CartItem> updatedCartItems = List.from(state.cartProducts);
    updatedCartItems.removeWhere((item) => item.product.id == event.product.id);
    emit(CartUpdated(cartProducts: updatedCartItems, totalPrice: _calculateTotalPrice(updatedCartItems)));
  }

  
  void _onIncrementQuantity(IncrementQuantity event, Emitter<CartState> emit){
    final updatingProduct = state.cartProducts.map((items) {
      if(items.product.id == event.product.id){
        items.quantity = event.quantity;
      }
      return items;
    }).toList();
    emit(CartState(cartProducts: updatingProduct, totalPrice: _calculateTotalPrice(updatingProduct)));
  }

  double _calculateTotalPrice(List<CartItem> cartItems){
    double total = 0;
    for(CartItem c in cartItems){
      total += c.quantity * c.product.price;
    }
    return total;
  }

  static void addToCart(BuildContext context, Product product){
    context.read<CartBloc>().add(AddToCart(product: product));
  }

  static void removeFromCart(BuildContext context, Product product){
    context.read<CartBloc>().add(RemoveFromCart(product: product));
  }

  static void incrementQuantity(BuildContext context, Product product, CartItem cartItem){
    if(cartItem.quantity < product.quantity){
      product.quantity--;
      context.read<CartBloc>().add(IncrementQuantity(product: product, quantity: cartItem.quantity + 1));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Số lượng sản phẩm trong kho không đủ!'),
        ),
      );
    }
  }

  static void decrementQuantity(BuildContext context, Product product, CartItem cartItem){
    if(cartItem.quantity > 1){
      product.quantity++;
      context.read<CartBloc>().add(IncrementQuantity(product: product, quantity: cartItem.quantity - 1));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Số lượng sản phẩm trong kho không đủ!'),
        ),
      );
    }
  }

}
