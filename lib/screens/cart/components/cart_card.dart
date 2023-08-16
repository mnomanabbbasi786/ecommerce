import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class CartCard extends StatelessWidget {
  CartCard(
      {Key? key,
      required this.id,
      required this.productName,
      required this.image,
      required this.price,
      required this.quantity})
      : super(key: key);

  var id;
  var productName;
  var image;
  var price;
  var quantity;

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
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
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
            Consumer<CartProvider>(builder: (context, cartItems, child) {
              return Text.rich(
                TextSpan(
                  text: "\$${price}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: " x${quantity}",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              );
            })
          ],
        ),
      ],
    );
  }
}
