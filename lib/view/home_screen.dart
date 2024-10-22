import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_final/view/widget/favorite_card.dart';
import 'package:mock_final/view/widget/product_card.dart';
import 'package:mock_final/view/widget/shopping_cart.dart';

import '../theme/style/style_color.dart';
import '../theme/style/style_text.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});


  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentPage = 0;

  final List<Widget> _pages = [
    const ProductCard(),
    ShoppingCart(),
    const FavoriteCard(),
    const Scaffold(body: Center(child: Text("Profile"),),),
  ];

  void _onTapped(int index){
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        selectedItemColor: StyleColor.darkBlueColor,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: StyleText.styleAirbnb(10, FontWeight.w400, Colors.black),
        unselectedFontSize: 2,
        currentIndex: currentPage,
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
            icon: Container(width: 20,height: 20,child: Image.asset("assets/images/home.png"),),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            tooltip: 'Cart Page',
            icon: Container(width: 20,height: 20,child: Image.asset("assets/images/cart.png"),),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Container(width: 20,height: 20,child: Image.asset("assets/images/heart.png"),),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Container(width: 20,height: 20,child: Image.asset("assets/images/person.png"),),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
