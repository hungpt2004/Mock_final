import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../model/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  //Object list was comparable with list
  //abstract to override
  @override
  List<Object?> get props => [];
}

//Function add
class AddToCart extends CartEvent {
  final Product product;

  const AddToCart({required this.product});

  //Override method of CartEvent override props with product
  //Equatable compare true event AddToCart
  @override
  List<Object?> get props => [product];
}

//Function remove
class RemoveFromCartById extends CartEvent {
  final int productId;

  const RemoveFromCartById({required this.productId});

  //Two object will be equal if their productId equal
  @override
  List<Object?> get props => [productId];
}

//Function clear all
class ClearCart extends CartEvent {
  const ClearCart();

  @override
  List<Object?> get props => [];
}

// Function checkout
class CheckoutCart extends CartEvent {
  final BuildContext context;

  const CheckoutCart({required this.context});

  @override
  List<Object?> get props => [context];
}


