import 'package:ecommerce/credentials/credentails_auth.dart';
import 'package:ecommerce/database/AuthenticationsRepostry.dart';
import 'package:ecommerce/models/CartModel.dart';
import 'package:ecommerce/provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/fluttertoat.dart';
import '/components/default_button.dart';
import '/size_config.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  var id;
  var productName;
  var image;
  var rrPrice;

  Body({
    Key? key,
    required this.id,
    required this.rrPrice,
    required this.image,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return ListView(
      children: [
        ProductImages(
          image: image,
          id: id,
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                pressOnSeeMore: () {},
                image: image,
                rrPrice: rrPrice,
                productName: productName,
                id: id,
              ),
              TopRoundedContainer(
                color: const Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(
                      id: id,
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () async {
                            cart.addToCart(item: CartModel(
                                id: id,
                                productName: productName,
                                price: rrPrice,
                                quantity: ColorDots.quantity,
                                productId: id,
                                userID: SupabaseCredentials.supabaseClient.auth.currentUser!.id,
                                image: image));
                            ToastUtil.showCustomToast(
                              context: context,
                              message: "Product Add to Cart",
                              iconData: Icons.done,
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
