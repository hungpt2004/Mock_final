import '../../model/product.dart';

class FavoriteState {
  final List<Product> favorite;

  FavoriteState({required this.favorite});
}

class FavoriteLoadingProgress extends FavoriteState {

  FavoriteLoadingProgress() : super(favorite: []);

}

class FavoriteUpdated extends FavoriteState {

  FavoriteUpdated({required super.favorite});

}

class FavoriteFailure extends FavoriteState {

  FavoriteFailure({required super.favorite});

}


