
import 'package:ecommerce/database/AuthenticationsRepostry.dart';
import 'package:ecommerce/provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context);
    cartItems.fetchItems(userId: AuthenticationsRepostry.currentUser);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Consumer<CartProvider>(builder: (context, cartItems, child) {
            return Text(
              "${cartItems.items.length} items",
              style: Theme.of(context).textTheme.caption,
            );
          }),
        ],
      ),
    );
  }
}
