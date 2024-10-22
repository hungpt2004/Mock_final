import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_final/bloc/cart/cart_bloc.dart';
import 'package:mock_final/bloc/favourite/favorite_state.dart';
import 'package:mock_final/model/product.dart';
import '../../theme/action/scaffold_msg.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';


class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  List<Product> _favorite = [];

  FavoriteBloc() : super(FavoriteLoadingProgress()) {
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
  }

  void _onAddFavorite(AddFavorite event, Emitter<FavoriteState> emit){
    bool existed = _favorite.any((items) => items.id == event.product.id);
    if(!existed){
      _favorite.add(event.product);
    } else {
      emit(FavoriteFailure(favorite: _favorite));
    }
    emit(FavoriteUpdated(favorite: _favorite));
  }

  void _onRemoveFavorite(RemoveFavorite event, Emitter<FavoriteState> emit){
    final favorites = _favorite.where((items) => items.id != event.productId).toList();
    emit(FavoriteUpdated(favorite: favorites));
  }

  static void addFavorite(BuildContext context, Product product){
    context.read<FavoriteBloc>().add(AddFavorite(product: product));
    showCustomSnackBar(context, "Add favorite successfully",isSuccess: true);
  }

  static void removeFavorite(BuildContext context, Product product){
    context.read<FavoriteBloc>().add(RemoveFavorite(productId: product.id));
    showCustomSnackBar(context, "Remove favorite successfully",isSuccess: true);
  }

}
