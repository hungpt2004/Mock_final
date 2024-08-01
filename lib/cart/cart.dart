import 'package:equatable/equatable.dart';
import '../model/product.dart';

class CartModel extends Equatable {
  final Product product;
  final int quantity;

  const CartModel({
    required this.product,
    required this.quantity,
  });

  int get totalPrice => product.price * quantity;

  @override
  List<Object> get props => [product, quantity];
}
