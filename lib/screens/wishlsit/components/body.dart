import 'package:ecommerce/provider/WishListProvider.dart';
import 'package:ecommerce/screens/wishlsit/components/WishlistCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';


class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Consumer<WishListProvider>(builder: (context, wishlistItems, child) {
          return ListView.builder(
            itemCount: wishlistItems.items.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: WishlistCard(
                image: wishlistItems.items[index].image,
                id: wishlistItems.items[index].id,
                productName: wishlistItems.items[index].productName,
                price: wishlistItems.items[index].price,
              ),
            ),
          );
        }));
  }
}
