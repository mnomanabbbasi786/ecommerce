import 'package:ecommerce/components/fluttertoat.dart';
import 'package:ecommerce/screens/wishlsit/WishListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../screens/darkmodebutton.dart';
import '/screens/home/home_screen.dart';
import '/screens/profile/profile_screen.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;
  void navigateTo(BuildContext context, String routeName, Widget screen) {
    if (Navigator.canPop(context)) {
      Navigator.popUntil(context, (route) {
        if (route.settings.name == routeName) {
          // If we found the route, don't pop anymore.
          return true;
        }
        // Continue popping.
        return false;
      });
    }
    if (ModalRoute.of(context)?.settings.name != routeName) {
      // If current route isn't the desired route, push it onto the stack.
      Navigator.pushNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    bool isCurrentRoute(String routeName) {
      return ModalRoute.of(context)?.settings.name == routeName;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: themeProvider.isDark ? Colors.grey[800] : Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    if (!isCurrentRoute(HomeScreen.routeName)) {
                      navigateTo(context, HomeScreen.routeName, HomeScreen());
                    } else {
                      ToastUtil.showCustomToast(
                          message: "Already on that screen",
                          iconData: Icons.smart_screen,
                          context: context);
                    }
                  }),
              IconButton(
                  icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
                  color: MenuState.favourite == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  onPressed: () {
                    if (!isCurrentRoute(WishListScreen.routeName)) {
                      navigateTo(
                          context, WishListScreen.routeName, WishListScreen());
                    } else {
                      ToastUtil.showCustomToast(
                          message: "Already on that screen",
                          iconData: Icons.smart_screen,
                          context: context);
                    }
                  }),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
                onPressed: () {},
              ),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/User Icon.svg",
                    color: MenuState.profile == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    if (!isCurrentRoute(ProfileScreen.routeName)) {
                      navigateTo(
                          context, ProfileScreen.routeName, ProfileScreen());
                    } else {
                      ToastUtil.showCustomToast(
                          message: "Already on that screen",
                          iconData: Icons.smart_screen,
                          context: context);
                    }
                  }),
            ],
          )),
    );
  }
}
