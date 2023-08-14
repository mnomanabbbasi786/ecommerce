import 'package:ecommerce/screens/productScreen/PopularProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../database/PopularProductRepostry.dart';
import '../../../models/ProductModel.dart';
import '../../../provider/PopularProductProvider.dart';
import '/components/product_card.dart';
import '/models/Product.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {

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
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Popular Products",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PopularProductScreen()));
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        NotificationListener<ScrollNotification>(
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  productData.length,
                  (index) {
                    return ProductCard(
                      id: productData[index].id,
                      productName: productData[index].productName,
                      rrPrice: productData[index].rrPrice,
                      image: productData[index].image,
                    );
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            height: isLoading ? 50.0 : 0.0,
            child: CircularProgressIndicator(),
          ),
        ),
        Center(
          child: Container(
            height: hasMoreData ? 50.0 : 0.0,
            child: Text("You have watched all the posts${productData.length}"),
          ),
        )
      ],
    );
  }
}
