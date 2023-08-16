import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../darkmodebutton.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: themeProvider.isDark
            ? Colors.white
                .withOpacity(0.2) // Adjust opacity for dark mode if needed
            : kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: InputDecoration(
          focusColor:
              themeProvider.isDark ? Color(0xFFF5F6F9) : Colors.grey[800],
          contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(9)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: "Search product",
          hintStyle: TextStyle(
            color: themeProvider.isDark ? Color(0xFFF5F6F9) : Colors.grey[500],
          ),
          prefixIcon: Icon(
            Icons.search,
            color: themeProvider.isDark ? Color(0xFFF5F6F9) : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}
