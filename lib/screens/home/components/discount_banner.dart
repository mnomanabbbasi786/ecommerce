import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange,
            Colors.deepOrangeAccent,
            Colors.orange,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text.rich(
            TextSpan(
              style: const TextStyle(color: Colors.white),
              children: [
                const TextSpan(text: "A Summer Surpise\n"),
                TextSpan(
                  text: "   Cashback 30%",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(25),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            width: 80, // or desired width
            height: 85, // or desired height
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sale.png"),
                // This makes sure the image fills the circle
              ),
            ),
          ),
        ],
      ),
    );
  }
}
