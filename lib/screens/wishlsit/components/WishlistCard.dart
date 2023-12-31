import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../darkmodebutton.dart';
import '/models/Cart.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class WishlistCard extends StatelessWidget {
  WishlistCard({
    Key? key,
    required this.id,
    required this.productName,
    required this.image,
    required this.price,

  }) : super(key: key);

  var id;
  var productName;
  var image;
  var price;



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedNetworkImage(
                imageUrl: image,
                fadeInDuration: const Duration(
                    seconds: 1), // control the fade in duration
                placeholder: (context, url) => Container(
                    color: Colors
                        .transparent), // transparent container as placeholder
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style:  TextStyle(color: themeProvider.isDark?Colors.white: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Consumer<CartProvider>(
                builder: (context,cartItems,child){
                  return Text.rich(
                    TextSpan(
                      text: "\$${price}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                    ),
                  );
                }
            )
          ],
        ),
      ],
    );
  }
}
