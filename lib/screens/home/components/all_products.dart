
import 'package:ecommerce/components/product_card.dart';
import 'package:ecommerce/database/PopularProductRepostry.dart';
import 'package:ecommerce/models/ProductModel.dart';
import 'package:ecommerce/provider/CategoryProvider.dart';
import 'package:ecommerce/screens/home/components/categories.dart';
import 'package:ecommerce/screens/home/components/section_title.dart';
import 'package:ecommerce/screens/productScreen/AllProductScreen.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';


class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}


class _AllProductsState extends State<AllProducts> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Products",

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
          child: Consumer<CategoryProvider>(
            builder: (context,categoryProvider,child){
              return  Row(
                children: [
                  ...List.generate(
                    categoryProvider.tempLength,
                        (index) {

                      return ProductCard(
                        id: categoryProvider.product[index].id,
                        productName: categoryProvider.product[index].productName,
                        rrPrice: categoryProvider.product[index].rrPrice,
                        image: categoryProvider.product[index].image,
                      );
                    },
                  ),
                  categoryProvider.tempLength ==0?Text('No Products',style: TextStyle(color: Colors.deepOrange),):
                  SizedBox(width: getProportionateScreenWidth(20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0), // space around the button
                      decoration: BoxDecoration(
                        color: Colors.orange, // background color
                        borderRadius:
                        BorderRadius.circular(30.0), // rounded corners
                        boxShadow: [
                          // shadow to give 3D effect
                          BoxShadow(
                            color: Colors.deepOrange.withOpacity(0.5),
                            offset: const Offset(5, 5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-5, -5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward,
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
              );
            }
          )
        ),
        // isLoading
        //     ? const Center(
        //         child: SizedBox(
        //         child: PlayStoreShimmer(
        //           isPurplishMode: true,
        //           colors: [Colors.grey],
        //         ),
        //       ))
        //     : Container(),
      ],
    );
  }
}
