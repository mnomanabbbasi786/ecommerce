import 'package:ecommerce/screens/productScreen/PopularProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/error.dart';
import '../../../provider/WishListProvider.dart';
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
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            const DiscountBanner(),
            Categories(),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
            ErrorBoundary(child: const AllProducts()),
          ],
        ),
      ),
    );
  }
}
