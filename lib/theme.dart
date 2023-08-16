import 'package:ecommerce/screens/notification/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(
      color: mainText,
      fontFamily: 'Inter',
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),

    //this font we will use later 'H2'

    headline2: TextStyle(
      color: mainText,
      fontFamily: 'Inter',
      fontSize: 17,
      fontWeight: FontWeight.w700,
    ),
    //this font we will use  later 'H3'

    headline3: TextStyle(
      fontFamily: 'Inter',
      fontSize: 15,
      fontWeight: FontWeight.w700,
    ),

    //this font we will use later 'P1'

    bodyText1: TextStyle(
      color: SecondaryText,
      fontFamily: 'Inter',
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),

    //this font we will use later 'P2'

    bodyText2: TextStyle(
      fontFamily: 'Inter',
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    //this font we will use later 'S'
    subtitle1: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    toolbarTextStyle: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ).bodyText2,
    titleTextStyle: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ).headline6,
  );
}

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    fontFamily: "Muli",
    appBarTheme: darkAppBarTheme(),
    textTheme: darkTextTheme(),
    inputDecorationTheme: darkInputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme darkInputDecorationTheme() {
  OutlineInputBorder darkOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: Colors.white70),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: darkOutlineInputBorder,
    focusedBorder: darkOutlineInputBorder,
    border: darkOutlineInputBorder,
  );
}

TextTheme darkTextTheme() {
  return TextTheme(
    headline1: TextStyle(
      color: Colors.white70,
      fontFamily: 'Inter',
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
    headline2: TextStyle(
      color: Colors.white70,
      fontFamily: 'Inter',
      fontSize: 17,
      fontWeight: FontWeight.w700,
    ),
    headline3: TextStyle(
      color: Colors.white70,
      fontFamily: 'Inter',
      fontSize: 15,
      fontWeight: FontWeight.w700,
    ),
    bodyText1: TextStyle(
      color: Colors.white60,
      fontFamily: 'Inter',
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),
    bodyText2: TextStyle(
      color: Colors.white60,
      fontFamily: 'Inter',
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: TextStyle(
      color: Colors.white38,
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
}

AppBarTheme darkAppBarTheme() {
  return AppBarTheme(
    color: Colors.grey[800],
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    toolbarTextStyle: TextTheme(
      headline6: TextStyle(color: Colors.white70, fontSize: 18),
    ).bodyText2,
    titleTextStyle: TextTheme(
      headline6: TextStyle(color: Colors.white70, fontSize: 18),
    ).headline6,
  );
}
