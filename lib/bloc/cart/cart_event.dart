import 'package:mock_final/model/product.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent{
  final Product product;
  AddToCart({required this.product});
}

class RemoveFromCart extends CartEvent{
  final Product product;
  RemoveFromCart({required this.product});
}

class IncrementQuantity extends CartEvent{
  final Product product;
  final int quantity;

  IncrementQuantity({required this.product, required this.quantity});
}

class ClearAll extends CartEvent {}
