import 'package:ecommerce/credentials/credentails_auth.dart';
import 'package:ecommerce/provider/CartProvider.dart';
import 'package:ecommerce/provider/PopularProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/routes.dart';
import '/screens/profile/profile_screen.dart';
import '/screens/splash/splash_screen.dart';
import '/theme.dart';

void main() {
  Supabase.initialize(url: SupabaseCredentials.APIurl, anonKey: SupabaseCredentials.APIKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>PopularProductProvider()),
          ChangeNotifierProvider(create: (context)=>CartProvider())
        ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        // home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
