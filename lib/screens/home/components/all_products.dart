import 'dart:convert';

import 'package:ecommerce/components/fluttertoat.dart';
import 'package:ecommerce/components/product_card.dart';
import 'package:ecommerce/database/PopularProductRepostry.dart';
import 'package:ecommerce/models/ProductModel.dart';
import 'package:ecommerce/models/WishlistModel.dart';
import 'package:ecommerce/provider/WishListProvider.dart';
import 'package:ecommerce/screens/home/components/section_title.dart';
import 'package:ecommerce/screens/productScreen/AllProductScreen.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



List<ProductModel> product = [];
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
    var response = await PopularProductRepostry.fetchPopularProduct(start, end);
    await PopularProductRepostry.fetchPopularProductLength();
    productData.addAll(response);
    await storeProductData(productData);
    isLoading = false;
    setState(() {});
  }

  String serializeProductData(List<ProductModel> products) {
    // Convert the list of ProductModel objects to a list of maps (JSON-like format)
    List<Map<String, dynamic>> productJsonList =
        products.map((product) => product.toJson()).toList();

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
      List<ProductModel> storedProducts =
          getProductDataFromPrefs(productDataJson);
      product.addAll(storedProducts);
      setState(() {

      });
    } catch (error) {
      print('Error storing product data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    print("products $product");

    if (product.isEmpty) {
      fetchPopularProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                product.length,
                (index) {
                  return Consumer<WishListProvider>(
                      builder: (context, wishListItem, child) {
                    return ProductCard(
                      isFavorite: true,
                      onTap: () {
                        if (wishListItem.selectItem
                            .contains(product[index].id)) {
                          wishListItem.removeItem(product[index].id);
                          ToastUtil.showCustomToast(
                            context: context,
                            message: "Removed from wishlist",
                            iconData: Icons.remove_circle_outline,
                          );
                        } else {
                          wishListItem.addItem(
                              productData[index].id,
                              WishlistModel(
                                  id: product[index].id,
                                  productName: product[index].productName,
                                  price: product[index].rrPrice,
                                  image: product[index].image));
                          ToastUtil.showCustomToast(
                            context: context,
                            message: "Added to wish list",
                            iconData: Icons.done,
                          );
                        }

                      },
                      id: product[index].id,
                      productName: product[index].productName,
                      rrPrice: product[index].rrPrice,
                      image: product[index].image,
                    );
                  });
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 10.0), // space around the button
                  decoration: BoxDecoration(
                    color: Colors.orange, // background color
                    borderRadius:
                        BorderRadius.circular(30.0), // rounded corners
                    boxShadow: [
                      // shadow to give 3D effect
                      BoxShadow(
                        color: Colors.deepOrange.withOpacity(0.5),
                        offset: Offset(5, 5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, -5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward,
                        color: Colors.white), // icon color
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllProductsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        isLoading
            ? const Center(
                child: SizedBox(
                child: PlayStoreShimmer(
                  isPurplishMode: true,
                  colors: [Colors.grey],
                ),
              ))
            : Container(),
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
