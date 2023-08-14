import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/routes.dart';
import '/screens/profile/profile_screen.dart';
import '/screens/splash/splash_screen.dart';
import '/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen') ?? false;
  String initialRoute = seen ? HomeScreen.routeName : SplashScreen.routeName;

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HSE-ecommerce',
      theme: theme(),
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
