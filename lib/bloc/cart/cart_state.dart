import 'package:mock_final/model/cart.dart';


class CartState {
  final List<CartItem> cartProducts;
  final double totalPrice;

  CartState({required this.cartProducts, required this.totalPrice});
}

//State Load
class CartLoadInProgress extends CartState {
  CartLoadInProgress() : super(cartProducts: [],totalPrice: 0);
}
//Status updated
class CartUpdated extends CartState {
  CartUpdated({required super.cartProducts, required super.totalPrice});
}
//Status Failure
class CartLoadFailure extends CartState {
  CartLoadFailure({required super.cartProducts, required super.totalPrice});
}
