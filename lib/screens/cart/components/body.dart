import 'package:ecommerce/provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Consumer<CartProvider>(builder: (context, cartItems, child) {
          return ListView.builder(
            itemCount: cartItems.items.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(
                    cartItems.items[index].id), // Use the item ID as the key
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  cartItems.delete(cartItems.items[index].id);
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(
                  image: cartItems.items[index].image,
                  id: cartItems.items[index].id,
                  productName: cartItems.items[index].productName,
                  price: cartItems.items[index].price,
                  quantity: cartItems.items[index].quantity,
                ),
              ),
            ),
          );
        }));
  }
}
