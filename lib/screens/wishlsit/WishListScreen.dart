
import 'package:ecommerce/screens/wishlsit/components/body.dart';
import 'package:flutter/material.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../provider/WishListProvider.dart';
import 'package:provider/provider.dart';
class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  static String routeName = "/wishlist";

  @override
  Widget build(BuildContext context) {
    final wishlsit = Provider.of<WishListProvider>(context);
    wishlsit.fetchWishlist();
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        automaticallyImplyLeading: true,
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite,),
    );
  }
}
