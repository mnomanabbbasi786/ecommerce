
import 'package:ecommerce/database/CartRepositry.dart';
import 'package:ecommerce/provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatelessWidget {


  String? uuid;

  Body({super.key,required this.uuid});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.setPrice(0);

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: FutureBuilder(
          future: CartRepositry.fetchCartItems(userID:uuid),
          builder: (context,snapShot){
            if(snapShot.connectionState == ConnectionState.waiting){
              return const PlayStoreShimmer(isPurplishMode: false,);
            }
            else  if(snapShot.hasData){
              return ListView.builder(
                itemCount: snapShot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(snapShot.data![index].id), // Use the item ID as the key
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        CartRepositry.deleteFromCart(uuid!);
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            SvgPicture.asset("assets/icons/Trash.svg"),
                          ],
                        ),
                      ),
                      child: CartCard(
                        image: snapShot.data![index].image,
                        id:snapShot.data![index].id,
                        productName: snapShot.data![index].productName,
                        price:snapShot.data![index].price,
                        quantity: snapShot.data![index].quantity,
                      ),
                    ),
                  );
                },
              );
            }else{
              return Container();
            }

          }
        ));
  }
}
