import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_final/bloc/favourite/favorite_bloc.dart';
import 'package:mock_final/bloc/favourite/favorite_state.dart';
import 'package:mock_final/theme/style/style_appbar.dart';
import 'package:mock_final/theme/style/style_space.dart';

import '../../theme/style/style_color.dart';
import '../../theme/style/style_text.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({super.key});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state){
        if(state is FavoriteLoadingProgress){
          return Scaffold(
            appBar: StyleAppBar.Widget("Favorite Products"),
            body: const Center(
              child: Text("No have any product favorite here !"),
            ),
          );
        } else {
          return Scaffold(
            appBar: StyleAppBar.Widget("Favorite Products"),
            body: SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: state.favorite.length,
                itemBuilder: (context, index) {
                  final productIndex = state.favorite[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                    child: Card(
                      elevation: 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  productIndex.image,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0),
                                    child: Text(
                                        productIndex.name,
                                        style: StyleText.styleAirbnb(
                                            14,
                                            FontWeight.w400,
                                            Colors.black)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0),
                                    child: Text(
                                        "${productIndex.description} - ${productIndex.condition}",
                                        style: StyleText.styleAirbnb(
                                            14,
                                            FontWeight.w400,
                                            Colors.black)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0),
                                    child: Text(
                                      '\$${productIndex.price.toStringAsFixed(2)}',
                                      style: StyleText.styleAirbnb(
                                          14,
                                          FontWeight.w500,
                                          Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(onPressed: (){
                                    FavoriteBloc.removeFavorite(context, productIndex);
                                  }, child: Image.asset("assets/images/bin.png",width: 20,height: 30,)),
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
