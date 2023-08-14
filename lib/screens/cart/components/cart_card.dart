import 'package:ecommerce/provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
   CartCard({
    Key? key,
    required this.id,
     required this.productName,
     required this.image,
     required this.price
  }) : super(key: key);

var id;
var productName;
var image;
var price;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(image),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Consumer<CartProvider>(
              builder: (context,cartItems,child){
                return Text.rich(
                  TextSpan(
                    text: "\$${price}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " x${cartItems.items.length}",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                );
              }
            )
          ],
        )
      ],
    );
  }
}
