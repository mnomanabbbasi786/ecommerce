import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../screens/darkmodebutton.dart';
import '/screens/details/details_screen.dart';
import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {Key? key,
      this.width = 140,
      this.aspectRetio = 1.02,
      this.id,
      this.productName,
      this.rrPrice,
      this.image,
      required this.isFavorite,
      this.onTap})
      : super(key: key);
  var id;
  var productName;
  var image;
  var rrPrice;
  bool isFavorite;
  dynamic onTap;
  final double width, aspectRetio;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(
                rrPrice: rrPrice,
                productName: productName,
                image: image,
                id: id),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.04,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(16)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                      tag: id,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fadeInDuration: Duration(
                            seconds: 1), // control the fade in duration
                        placeholder: (context, url) => Container(
                            color: Colors
                                .transparent), // transparent container as placeholder
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                productName,
                style: TextStyle(
                    color: themeProvider.isDark ? Colors.white : Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${rrPrice}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: isFavorite
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color:
                            isFavorite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
