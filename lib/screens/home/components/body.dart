import 'package:ecommerce/screens/productScreen/PopularProductScreen.dart';
import 'package:flutter/material.dart';
import '../../../components/error.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'all_products.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
             HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            const DiscountBanner(),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            Categories(),
            ErrorBoundary(child: const AllProducts()),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
          ],
        ),
      ),
    );
  }
}
