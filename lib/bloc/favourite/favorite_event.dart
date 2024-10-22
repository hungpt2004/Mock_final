
import '../../model/product.dart';

abstract class FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  final Product product;

  AddFavorite({required this.product});
}

class RemoveFavorite extends FavoriteEvent {
  final int productId;

  RemoveFavorite({required this.productId});
}