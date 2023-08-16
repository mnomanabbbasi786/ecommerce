import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(
          rating: agrs.rrPrice,
        ),
      ),
      body: Body(
          image: agrs.image,
          id: agrs.id,
          productName: agrs.productName,
          rrPrice: agrs.rrPrice,
         ),
    );
  }
}

class ProductDetailsArguments {
  var id;
  var productName;
  var rrPrice;
  var image;

  ProductDetailsArguments(
      {required this.id,
      required this.productName,
      required this.rrPrice,
      required this.image});
}
