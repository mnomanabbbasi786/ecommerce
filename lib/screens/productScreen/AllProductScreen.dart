import 'package:ecommerce/screens/productScreen/components/body.dart';
import 'package:flutter/material.dart';


class AllProductsScreen extends StatelessWidget {
  static String routeName = "/popularproduct";

    String categoryName;
   AllProductsScreen({super.key,required this.categoryName});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Body(categoryName: categoryName,),
    );
  }
}
