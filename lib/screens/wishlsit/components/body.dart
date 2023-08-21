import 'package:ecommerce/database/WishlistRepostry.dart';

import 'package:ecommerce/screens/wishlsit/components/WishlistCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    Sentry.configureScope((scope) {
      scope.setTag('widget', 'WishList');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: FutureBuilder(
            future: WishlistRepostry.fetchWishList(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                return ListView.builder(
                    itemCount: snapShot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: WishlistCard(
                          image: snapShot.data![index].image,
                          id: snapShot.data![index].id,
                          productName: snapShot.data![index].productName,
                          price: snapShot.data![index].price,
                        ),
                      );
                    });
              } else {
                return  Center(
                  child: RotatedBox(
                    quarterTurns: 1, // 90-degree rotation
                    child: Container(
                      width: MediaQuery.of(context).size.height, // Make sure the container covers the screen width
                      height: MediaQuery.of(context).size.width, // Make sure the container covers the screen height
                      child: PlayStoreShimmer(
                        isPurplishMode: false,
                        // Adjust shimmer properties here
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
