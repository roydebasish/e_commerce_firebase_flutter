import 'package:e_commerce_firebase_flutter/utils/color.dart';
import 'package:e_commerce_firebase_flutter/views/CartScreen/cart_screen.dart';
import 'package:e_commerce_firebase_flutter/views/HomeScreen/home_screent.dart';
import 'package:flutter/material.dart';
class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {

  int selectedIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Fav Screen'),),
    const CartScreen(),
    const Center(child: Text('Profile Screen'),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
        ],
      ),
    );
  }
}
