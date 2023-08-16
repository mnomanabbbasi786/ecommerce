import 'dart:convert';

import 'package:ecommerce/provider/WishListProvider.dart';
import 'package:ecommerce/screens/productScreen/AllProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../database/PopularProductRepostry.dart';
import '../../../models/ProductModel.dart';
import '../../../models/WishlistModel.dart';
import '/components/product_card.dart';
import '../../../size_config.dart';
import 'section_title.dart';
List<ProductModel> product =[];
bool isLoading = true;

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}


class _AllProductsState extends State<AllProducts> {


  int start = 0;
  int end = 50;



  List<ProductModel> productData = [];

  var hasMoreData = false;

  fetchPopularProducts() async {
    var response =
      await PopularProductRepostry.fetchPopularProduct(start, end);
    await PopularProductRepostry.fetchPopularProductLength();
    productData.addAll(response);
    storeProductData(productData);
    isLoading = false;
    setState(() {});
  }

  String serializeProductData(List<ProductModel> products) {
    // Convert the list of ProductModel objects to a list of maps (JSON-like format)
    List<Map<String, dynamic>> productJsonList = products.map((product) => product.toJson()).toList();

    // Convert the list of maps to a JSON string
    return json.encode(productJsonList);
  }

  List<ProductModel> getProductDataFromPrefs(String? productDataJson) {
    final List<dynamic> productJsonList = json.decode(productDataJson!);
    List<ProductModel> products = productJsonList
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
    return products;
  }

  storeProductData(List<ProductModel> products) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String productDataJson = serializeProductData(products);
      prefs.setString('productData', productDataJson);
      List<ProductModel> storedProducts = getProductDataFromPrefs(productDataJson);
        product.addAll(storedProducts);
    } catch (error) {
      print('Error storing product data: $error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(product);
    if(product.isEmpty){
      fetchPopularProducts();
    }

  }



  @override
  Widget build(BuildContext context) {
    final  wishilistProvider = Provider.of<WishListProvider>(context);
    wishilistProvider.fetchWishlistId();
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "All Products",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllProductsScreen()));
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!isLoading && (scrollInfo.metrics.maxScrollExtent -
                scrollInfo.metrics.pixels)
                .round() <=
                200)  {
              start = end;
              if ((end + 50) > PopularProductRepostry.length) {
                end = PopularProductRepostry.length;
                hasMoreData = true;
              } else {
                end = end + 50;
              }
              if(product.length == PopularProductRepostry.length){

              }else{
                fetchPopularProducts();
              }

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
                  product.length,
                  (index) {
                    return Consumer<WishListProvider>(
                      builder: (context,wishListItem,child){
                        return ProductCard(
                          isFavorite: wishListItem.selectItem.contains(product[index].id),
                          onTap: (){
                            if(wishListItem.selectItem.contains(product[index].id)){
                              wishListItem.removeItem(product[index].id);

                            }else{
                              wishListItem.addItem(productData[index].id,WishlistModel(
                                  id: product[index].id,
                                  productName: product[index].productName,
                                  price: product[index].rrPrice,
                                  image: product[index].image
                              ));
                            }
                          },
                          id: product[index].id,
                          productName: product[index].productName,
                          rrPrice: product[index].rrPrice,
                          image: product[index].image,
                        );
                      }
                    );
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          ),
        ),
       isLoading? const Center(
          child:SizedBox(
            child:  PlayStoreShimmer( isPurplishMode: true, colors: [Colors.grey],),
          )
        ):Container(),
        Center(
          child: SizedBox(
            height: hasMoreData ? 50.0 : 0.0,
            child: Text("You have watched all the posts${productData.length}"),
          ),
        )
      ],
    );
  }
}
