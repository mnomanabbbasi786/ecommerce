import 'package:ecommerce/database/AuthenticationsRepostry.dart';
import 'package:flutter/material.dart';
import '../../notification/notificationTap.dart';
import '/screens/cart/cart_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  String? uuid;
   HomeHeader({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () async{
              uuid=await AuthenticationsRepostry.getUserIdFromPrefs();
              print(uuid);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen(uuid: uuid)));
            },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () => Navigator.pushNamed(context, NotitcationTap.routeName),
          ),
        ],
      ),
    );
  }
}
