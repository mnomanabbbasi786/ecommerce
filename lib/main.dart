
import 'package:ecommerce/credentials/credentails_auth.dart';
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


  runApp( MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context)=>WishListProvider()),
        ChangeNotifierProvider(create: (context)=>PopularProductProvider()),
        ChangeNotifierProvider(create: (context)=>CartProvider())
      ],
    child:
    MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {


  MyApp();

  @override
  Widget build(BuildContext context) {
    String initialRoute = SupabaseCredentials.supabaseClient.auth.currentUser?.id == null ? SplashScreen.routeName:HomeScreen.routeName;

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
