import 'package:equatable/equatable.dart';
import '../model/cart.dart';

class CartState extends Equatable {
  final List<CartModel> cartItems;

  const CartState({required this.cartItems});

  @override
  List<Object?> get props => [cartItems];

  int get totalPrice => cartItems.fold(0, (sum, item) => sum + item.totalPrice);
}

//State Load
class CartLoadInProgress extends CartState {
  const CartLoadInProgress({required List<CartModel> cartItems}) : super(cartItems: cartItems);
}
//Status updated
class CartUpdated extends CartState {
  const CartUpdated({required List<CartModel> cartItems}) : super(cartItems: cartItems);
}

//Status Failure
class CartLoadFailure extends CartState {
  const CartLoadFailure({required List<CartModel> cartItems}) : super(cartItems: cartItems);
}
