import 'package:ecommerce/provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/components/rounded_icon_btn.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class ColorDots extends StatefulWidget {
  ColorDots({Key? key, required this.id}) : super(key: key);

  var id;
  static var quantity = 1;
  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      ColorDots.quantity = 1;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    final itemQuantity = Provider.of<CartProvider>(context);
    List colors = [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ];
    int selectedColor = 3;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            colors.length,
            (index) => ColorDot(
              color: colors[index],
              isSelected: index == selectedColor,
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              setState(() {
                ColorDots.quantity = ColorDots.quantity - 1;
              });
              itemQuantity.setQuantity(ColorDots.quantity);
            },
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          Text('${ColorDots.quantity}'),
          SizedBox(width: getProportionateScreenWidth(20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                ColorDots.quantity = ColorDots.quantity + 1;
              });

              itemQuantity.setQuantity(ColorDots.quantity);
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
