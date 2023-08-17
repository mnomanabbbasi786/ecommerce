import 'package:ecommerce/models/WishlistModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../components/fluttertoat.dart';
import '../../../components/product_card.dart';
import '../../../database/PopularProductRepostry.dart';

import '../../../models/ProductModel.dart';
import '../../../provider/WishListProvider.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  int start = 0;
  int end = 50;
  bool isLoading = true;

  List<ProductModel> productData = [];
  var hasMoreData = false;

  fetchPopularProducts() async {
    print("FETCHING DATA");
    print('lenth${PopularProductRepostry.length}');
    print('start: $start');
    print('end: $end');
    var response =
        await PopularProductRepostry.fetchPopularProduct(start, end);
    PopularProductRepostry.fetchPopularProductLength();
    productData.addAll(response);
    print('data length: ${productData.length}');
    isLoading = false;
    setState(() {});
    print(productData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPopularProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: getProportionateScreenWidth(20)),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading && (scrollInfo.metrics.maxScrollExtent -
                  scrollInfo.metrics.pixels)
                  .round() <=
                  500)  {
                start = end;
                if ((end + 50) > PopularProductRepostry.length) {
                  end = PopularProductRepostry.length;
                  hasMoreData = true;
                } else {
                  end = end + 50;
                }
                fetchPopularProducts();
                setState(() {
                  isLoading = true;
                });

              }
              return true;
            },
            child: isLoading? const SizedBox(
              child:  PlayStoreShimmer( isPurplishMode: true,colors: [Colors.grey],),
            ): GridView.builder(
                itemCount: productData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.6),
                itemBuilder: (context, index) {
                  return Consumer<WishListProvider>(
                      builder: (context,wishListItem,child){
                        return ProductCard(
                          isFavorite: true,
                          onTap: (){
                            if( wishListItem.selectItem.contains(productData[index].id)){
                              wishListItem.removeItem(productData[index].id);
                              ToastUtil.showCustomToast(
                                context: context,
                                message: "Removed from wishlist",
                                iconData: Icons.remove_circle_outline,
                              );
                            }else{
                              wishListItem.addItem(productData[index].id,WishlistModel(
                                  id: productData[index].id,
                                  productName: productData[index].productName,
                                  price: productData[index].rrPrice,
                                  image: productData[index].image

                              ));
                              ToastUtil.showCustomToast(
                                context: context,
                                message: "Added to wish list",
                                iconData: Icons.done,
                              );
                            }
                          },
                          id: productData[index].id,
                          productName: productData[index].productName,
                          rrPrice: productData[index].rrPrice,
                          image: productData[index].image,
                        );
                      }
                  );
                }),
          ),
        ),
      ),
    );
  }
}
