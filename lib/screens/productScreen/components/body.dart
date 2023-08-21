
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import '../../../components/product_card.dart';
import '../../../database/PopularProductRepostry.dart';
import '../../../models/ProductModel.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  String categoryName;
   Body({super.key, required this.categoryName});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _length;
  int start = 0;
  int end = 20;
  bool isLoading = true;

  List<ProductModel> productData = [];
  var hasMoreData = false;

  fetchPopularProducts() async {
    _length = await PopularProductRepostry.fetchProductLength(categoryName: widget.categoryName);
    var response =
        await PopularProductRepostry.fetchProduct(start: start,end: end,categoryName: widget.categoryName);
    PopularProductRepostry.fetchProductLength(categoryName: widget.categoryName);
    productData.addAll(response);
    isLoading = false;
    setState(() {});
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
        title: const Text('Products'),
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
                if ((end + 50) > _length) {
                  end = _length;
                  hasMoreData = true;
                } else {
                  end = end + 50;
                }
                fetchPopularProducts();
                setState(() {

                });
              }
              return true;
            },
            child: isLoading? const SizedBox(
              child:  PlayStoreShimmer( isPurplishMode: false,),
            ): GridView.builder(
                itemCount: productData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.6),
                itemBuilder: (context, index) {
                  return ProductCard(
                    id: productData[index].id,
                    productName: productData[index].productName,
                    rrPrice: productData[index].rrPrice,
                    image: productData[index].image,
                  );
                }),
          ),
        ),
      ),
    );
  }
}
