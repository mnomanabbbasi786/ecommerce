import 'package:ecommerce/database/AuthenticationsRepostry.dart';
import 'package:ecommerce/provider/CartProvider.dart';
import 'package:ecommerce/screens/darkmodebutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  String? uuid;
   CartScreen({super.key, required  this.uuid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(uuid: uuid),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      title: Column(
        children: [
           Text(
            "Your Cart",
            style: TextStyle(color:themeProvider.isDark?Colors.white:Colors.black),
          ),
          Consumer<CartProvider>(builder: (context, cartItems, child) {
            return Text(
              "${cartItems.items.length} items",
              style: TextStyle(
                color: themeProvider.isDark?Colors.white:Colors.black,
                fontSize: 14
              ),
            );
          }),
        ],
      ),
    );
  }
}
