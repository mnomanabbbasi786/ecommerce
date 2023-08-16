import 'dart:js';

import 'package:ecommerce/provider/CartProvider.dart';
import 'package:ecommerce/provider/PopularProductProvider.dart';
import 'package:ecommerce/provider/WishListProvider.dart';
import 'package:ecommerce/screens/darkmodebutton.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/routes.dart';

import '/screens/splash/splash_screen.dart';
import '/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen') ?? false;
  String initialRoute = seen ? HomeScreen.routeName : SplashScreen.routeName;

  runApp( MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context)=>WishListProvider()),
        ChangeNotifierProvider(create: (context)=>PopularProductProvider()),
        ChangeNotifierProvider(create: (context)=>CartProvider())
      ],
    child:
    MyApp(initialRoute: initialRoute),
  )
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HSE-ecommerce',
      theme: theme(),
      darkTheme: darkTheme(),
      themeMode: themeProvider.themeMode,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
